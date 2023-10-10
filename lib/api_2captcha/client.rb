# frozen_string_literal: true
require 'net/http'
require 'uri'
require 'json'
require 'base64'
require 'open-uri'

module Api2Captcha
  class Client
    DEFAULT_DOMAIN = "2captcha.com"
    BASE_URL_FORMAT = "https://%s"

    attr_reader :api_key, :soft_id

    attr_accessor :domain, :callback,
                  :default_timeout,
                  :recaptcha_timeout,
                  :polling_interval

    def initialize(api_key, soft_id = 0, callback = nil)
      @api_key = api_key
      @soft_id = soft_id
      @callback = callback
      @default_timeout = 120
      @recaptcha_timeout = 600
      @polling_interval = 10
      @domain = DEFAULT_DOMAIN
    end

    def solve(method, return_id: false, **params)
      params = params.transform_keys(&:to_s)
      params["method"] = method
      params["key"] = @api_key
      params["soft_id"] = @soft_id
      params["json"] = 1

      if @callback
        params["pingback"] = @callback
        return_id = true
      end

      complete_params = get_params(params)
      captcha_id = send_request(complete_params)
      return captcha_id if return_id
      get_result(captcha_id)
    end

    def send(*args)
      raise ArgumentError,
      "Invalid arguments of the send method" unless args.size == 1

      arg = args.first
      if arg.is_a?(String)
        solve("POST", {}, arg, return_id: true)
      elsif arg.is_a?(Hash)
        method = arg.delete(:method) || "POST"
        solve(method, arg, return_id: true)
      else
        raise ArgumentError, "Invalid arguments of the send method"
      end
    end

    def get_result(captcha_id)
      uri = URI("#{base_url}/res.php?key=#{@api_key}&action=get&id=#{captcha_id}&json=1")
      start_time = Time.now

      loop do
        response = make_request(uri)

        case response
        when Net::HTTPSuccess
          response_json = JSON.parse(response.body)
          if response_json["status"] == 1
            response_json["captcha_id"] = captcha_id
            return response_json
          elsif response_json["request"] == "CAPCHA_NOT_READY"
            sleep(polling_interval)
          else
            raise ApiException, "API Error: #{response_json["request"]}"
          end
        else
          raise NetworkException, "Network Error: #{response.code.to_i}"
        end

        raise TimeoutException, "Timeout" if Time.now - start_time > default_timeout
      end
    end

    def report(captcha_id, is_correct)
      report = is_correct ? "reportgood" : "reportbad"
      uri = URI("#{base_url}/res.php?key=#{@api_key}&action=#{report}&id=#{captcha_id}")
      make_request(uri)
    end

    def get_balance
      response = make_res_request({ "action" => "getbalance" }, "getbalance")
      return response["request"].to_f
    end

    def normal(params)
      solve("post", params)
    end

    def text(params)
      solve("textcaptcha", params)
    end

    def recaptcha_v2(params)
      solve("userrecaptcha", params)
    end

    def recaptcha_v3(params)
      solve("userrecaptcha", params)
    end

    def funcaptcha(params)
      solve("funcaptcha", params)
    end

    def geetest(params)
      solve("geetest", params)
    end

    def hcaptcha(params)
      solve("hcaptcha", params)
    end

    def keycaptcha(params)
      solve("keycaptcha", params)
    end

    def capy(params)
      solve("capy", params)
    end

    def grid(params)
      params["recaptcha"] = 1
      solve("post", params)
    end

    def canvas(params)
      params["recaptcha"] = 1
      params["canvas"] = 1
      solve("post", params)
    end

    def coordinates(params)
      params["coordinatescaptcha"] = 1

      solve("post", params)
    end

    def rotate(params)
      solve("rotatecaptcha", params)
    end

    def geetest_v4(params)
      solve("geetest_v4", params)
    end

    def lemin(params)
      solve("lemin", params)
    end

    def turnstile(params)
      solve("turnstile", params)
    end

    def amazon_waf(params)
      solve("amazon_waf", params)
    end

    def audio(params)
      audio = params.delete("audio")
      audio_content = File.file?(audio) ? File.binread(audio) : audio

      params = params.merge(
        "body" => Base64.strict_encode64(audio_content),
        "lang" => params["lang"]
      )
      solve("audio", params)
    end

    def yandex(params)
      solve("yandex", params)
    end

    def cyber_siara(params)
      solve("cybersiara", params)
    end

    def data_dome(params)
      solve("datadome", params)
    end

    private

    def base_url
      BASE_URL_FORMAT % @domain
    end

    def send_request(params)
      uri = URI("#{base_url}/in.php")
      req = Net::HTTP::Post.new(uri)
      req.content_type = 'application/json'
      req.body = params.to_json
      captcha_id = get_captcha_id(make_request(uri, req))
    end

    def get_params(params)
      params["image"].nil? ? params : file_params(params)
    end

    def file_params(params)
      image = params.delete("image")
      hint_image = params.delete("hint_image")

      image_content = get_image_content(image)
      hint_image_content = get_image_content(hint_image) if hint_image
      result_params = {
        "method" => "base64",
        "body" => Base64.strict_encode64(image_content),
        "filename" => File.basename(image),
        "ext" => File.extname(image).delete(".")
      }

      result_params["imginstructions"] = Base64.strict_encode64(hint_image_content) if hint_image_content
      params.merge(result_params)
    end

    def get_image_content(image)
      return download_image(image) if image.start_with?('http')
      return File.binread(image) if File.file?(image)
      image
    end

    def download_image(url)
      response = URI.open(url)
      if response.status[0] != '200'
        raise StandardError, "File could not be downloaded from url: #{url}"
      end
      response.read
    end

    def handle_response(captcha_id)
      captcha_result = get_result(captcha_id) if @callback.nil?
      @callback&.call(captcha_id)
      captcha_result
    end

    def get_captcha_id(response)
      case response
      when Net::HTTPSuccess
        response_json = JSON.parse(response.body.strip)
        if response_json["status"] == 1
          response_json["request"]
        else
          raise ApiException, "API Error: #{response_json["request"]}"
        end
      else
        raise NetworkException, "Network Error: #{response.code.to_i}"
      end
    rescue JSON::ParserError => e
      raise "Failed to parse response: #{e.message}"
    end

    def make_request(uri, req = nil)
      if req.nil?
        Net::HTTP.get_response(uri)
      else
        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req)
        end
      end
    end

    def make_res_request(request, action)
      uri = URI("#{base_url}/res.php?key=#{@api_key}&action=#{action}&json=1")
      req = Net::HTTP::Post.new(uri)
      req.content_type = 'application/json'
      req.body = request.to_json

      response = make_request(uri, req)

      case response
      when Net::HTTPSuccess
        return JSON.parse(response.body)
      else
        raise Api2Captcha::NetworkException, "Network Error: #{response.code.to_i}"
      end
    end
  end
end


