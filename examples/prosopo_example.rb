
require_relative '../lib/api_2captcha'

client =  Api2Captcha.new(ARGV[0])

result = client.prosopo({
  pageurl: "https://www.twickets.live/",
  sitekey: "5EZVvsHMrKCFKp5NYNoTyDjTjetoVo1Z4UNNbTwJf1GfN6Xm"
})

puts "Result: #{result.inspect}"