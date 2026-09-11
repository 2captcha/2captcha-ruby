# frozen_string_literal: true

require "net/http"
require "uri"
require "json"
require "base64"
require "open-uri"

module Api2Captcha
  class GenericClient

        attr_accessor :domain, :callback, :default_timeout, :recaptcha_timeout,
                  :polling_interval, :api_key, :soft_id

    def initialize(api_key)
      @api_key = api_key
      @soft_id = soft_id
      @callback = callback
      @default_timeout = 120
      @recaptcha_timeout = 600
      @polling_interval = 10
      @soft_id = 4584
      @domain = DEFAULT_DOMAIN
    end

    def solve(data)
      data[:softId] = soft_id
    end
  end
end

#     public JSONObject solve(JSONObject jsonObject) throws Exception {
#         jsonObject.put("softId", softId);
#         JSONObject responseJsonObject = createTask(jsonObject);
#         this.taskId = responseJsonObject.getLong("taskId");
#
#         if (jsonObject.getJSONObject("task").has("callbackUrl")
#                 && !jsonObject.getJSONObject("task").getString("callbackUrl").isEmpty())
#             return responseJsonObject;
#         return getTaskResult(this.taskId);
#     }
