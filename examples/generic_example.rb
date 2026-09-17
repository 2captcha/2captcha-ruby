require_relative "../lib/api_2captcha"

key = ARGV[0]

client = Api2Captcha.generic_client(key)

captcha_params = {
  clientKey: key,
  languagePool: "en",
  task: {
    type: "TextCaptchaTask",
    comment: "If tomorrow is Saturday, what day is today?"
  }
}

begin
  result = client.solve(captcha_params)
rescue StandardError => e
  puts "Error occurred: #{e.message}"
end

puts "Result: #{result.inspect}"

# get balance
balance_params = {
  clientKey: key
}
begin
  result = client.getBalance(balance_params)
rescue StandardError => e
  puts "Error occurred: #{e.message}"
end

puts "Result: #{result.inspect}"
