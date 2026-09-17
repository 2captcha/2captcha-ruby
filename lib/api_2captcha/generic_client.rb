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
          if ((Time.now - startedAt).to_i < timeout)
            sleep(polling_interval)
          else 
            break
          end
          
          puts "GetTaskResult Request N:  #{requestNum += 1}"
          jsonObjectResponse = doRequest(getTaskResultUri, jsonObject);

          if(jsonObjectResponse.key?("errorId") && jsonObjectResponse["errorId"] > 0)
            return jsonObjectResponse
          end

          status = jsonObjectResponse["status"]
          if(status.eql?("ready"))
            return jsonObjectResponse
          end

        end
 
      raise StandardError, "Timeout #{timeout} seconds reached"
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

    end

    def getBalance(data)
        puts "Balance Request"
        return doRequest(getBalanceUri, data);
    end

    def reportCorrect(data)
        puts "Report Correct Request"
        return doRequest(reportCorrectUri, data);
    end
    
    def reportIncorrect(data)
        puts "Report Incorrect Request"
        return doRequest(reportIncorrectUri, data);
    end

  end
end
