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

# get balance --------------------------------------------
balance_params = {
  clientKey: key
}
begin
  result = client.getBalance(balance_params)
rescue StandardError => e
  puts "Error occurred: #{e.message}"
end

puts "Result: #{result.inspect}"

# Report Correct --------------------------------------------

begin
  return if client.taskId == -1

  report_correct_params = {
    clientKey: key,
    taskId: client.taskId
  }

  result = client.reportCorrect(report_correct_params)
rescue StandardError => e
  puts "Error occurred: #{e.message}"
end

puts "Result: #{result.inspect}"

# Report Incorrect --------------------------------------------

begin
  return if client.taskId == -1

  report_incorrect_params = {
    clientKey: key,
    taskId: client.taskId
  }

  result = client.reportIncorrect(report_incorrect_params)
rescue StandardError => e
  puts "Error occurred: #{e.message}"
end

puts "Result: #{result.inspect}"
