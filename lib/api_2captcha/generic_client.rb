# frozen_string_literal: true

require "net/http"
require "uri"
require "json"
require "base64"
require "open-uri"

module Api2Captcha
  class GenericClient

        attr_accessor :domain, :callback, :default_timeout, :recaptcha_timeout, :polling_interval, :api_key, :soft_id,
                  :createTaskUri, :getTaskResultUri, :getBalanceUri, :reportCorrectUri, :reportIncorrectUri





    def initialize(api_key)
      @api_key = api_key
      @callback = callback
      @default_timeout = 120
      @recaptcha_timeout = 600
      @polling_interval = 10
      @soft_id = 4584
      @createTaskUri = "https://api.rucaptcha.com/createTask"
      @getTaskResultUri = "https://api.rucaptcha.com/getTaskResult"
      @getBalanceUri = "https://api.rucaptcha.com/getBalance"
      @reportCorrectUri = "https://api.rucaptcha.com/reportCorrect"
      @reportIncorrectUri = "https://api.rucaptcha.com/reportIncorrect"
    end

    def solve(data)
      data[:softId] = soft_id
       response = createTask(data)
      #JSONObject responseJsonObject = createTask(jsonObject);
      #if (jsonObject.getJSONObject("task").has("callbackUrl")
      #          && !jsonObject.getJSONObject("task").getString("callbackUrl").isEmpty())
      #      return responseJsonObject;
      #  return getTaskResult(this.taskId);

    end

    def createTask(data)
        puts "CreateTask Request"
        return doRequest(createTaskUri, data);
    end

    def doRequest(uri, data)
      
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


=
end