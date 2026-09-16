require_relative "../lib/api_2captcha"

key = ARGV[0]

client = Api2Captcha.generic_client(key)

data = {
  clientKey: key,
  languagePool: "en",
  task: {
    type: "TextCaptchaTask",
    comment: "If tomorrow is Saturday, what day is today?"
  }
}

begin
  result = client.solve(data)
rescue StandardError => e
  puts "Error occurred: #{e.message}"
end

puts "Result: #{result.inspect}"

#    private void resolve(){
#         JSONObject innerJsonObject = new JSONObject()
#                 .put("type", "TextCaptchaTask")
#                 .put("comment", "If tomorrow is Saturday, what day is today?");
#
#         JSONObject jsonObject = new JSONObject();
#         jsonObject.put("clientKey", this.key);
#         jsonObject.put("languagePool", "en");
#         jsonObject.put("task", innerJsonObject);
#
#         try {
#             JSONObject resultJsonObject = apiClient.solve(jsonObject);
#             System.out.println("Result: " + resultJsonObject.toString());
#         } catch (Exception e) {
#             System.out.println("Error occurred: " + e.getMessage());
#         }
#     }
