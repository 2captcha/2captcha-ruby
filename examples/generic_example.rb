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
