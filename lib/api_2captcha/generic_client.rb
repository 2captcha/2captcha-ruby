# frozen_string_literal: true

require "net/http"
require "uri"
require "json"
require "base64"
require "open-uri"

module Api2Captcha
  class GenericClient

        attr_accessor :domain, :callback, :timeout, :recaptcha_timeout, :polling_interval, :apiKey, :soft_id,
                  :createTaskUri, :getTaskResultUri, :getBalanceUri, :reportCorrectUri, :reportIncorrectUri, :taskId

    def initialize(apiKey)
      @apiKey = apiKey
      @callback = callback
      @timeout = 120
      @recaptcha_timeout = 600
      @polling_interval = 10
      @soft_id = 4584
      @taskId = -1
      @createTaskUri = "https://api.rucaptcha.com/createTask"
      @getTaskResultUri = "https://api.rucaptcha.com/getTaskResult"
      @getBalanceUri = "https://api.rucaptcha.com/getBalance"
      @reportCorrectUri = "https://api.rucaptcha.com/reportCorrect"
      @reportIncorrectUri = "https://api.rucaptcha.com/reportIncorrect"
    end

    def solve(data)
      data[:softId] = soft_id
       
      responseJsonObject = createTask(data)
      @taskId = responseJsonObject["taskId"];
      return getTaskResult(taskId)
    end

    def getTaskResult(taskId)
        puts "getTaskResult"
        startedAt = Time.now

        jsonObject = {
          clientKey: apiKey,
          taskId: taskId
        }

        requestNum = 0;
        loop do
          if ((Time.now - startedAt).to_i < timeout)   #Time.now - start_time > default_timeout
            sleep(polling_interval)
          else 
            break
          end
          #if (now - startedAt < this.timeout) {
          #      Thread.sleep(this.pollingInterval * 1000);
          #  } else {
          #      break;
          #  }
        end
      raise Exception, "Timeout #{timeout} seconds reached"
    end

    def createTask(data)
        puts "CreateTask Request"
        return doRequest(createTaskUri, data);
    end

    def doRequest(uri, data)
      uri = URI.parse(uri)

      headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      
      begin
        response = Net::HTTP.post(uri, data.to_json, headers)
      rescue StandardError => e
        puts "Something went wrong: #{e.message}"
      end

      puts "Status: #{response.code}"
      puts "Body: #{response.body}"

      return JSON.parse(response.body)
      #return response
    end
    
  end
end




=begin
#         private JSONObject doRequest(String uri, JSONObject jsonObject) throws Exception {
        HttpRequest request = request(jsonObject, uri);
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        System.out.println("Status: " + response.statusCode());
        System.out.println("Body: " + response.body());

        JSONObject responseJsonObject = new JSONObject(response.body());
        return responseJsonObject;
    }


--------------------------------------------
require 'net/http'
require 'uri'
require 'json'

# 1. Define the URI and data
uri = URI.parse('https://example.com')
payload = {
  name: 'John Doe',
  email: 'john@example.com'
}

# 2. Set up the Net::HTTP object
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true if uri.scheme == 'https' # Enable SSL for HTTPS URLs

# 3. Create the POST request
request = Net::HTTP::Post.new(uri.request_uri)
request['Content-Type'] = 'application/json'
request['Accept'] = 'application/json'
request.body = payload.to_json

# 4. Send the request and handle the response
response = http.request(request)

if response.code == '200' || response.code == '201'
  puts "Success!"
  puts JSON.parse(response.body)
else
  puts "Error: #{response.code} - #{response.message}"
end

=end