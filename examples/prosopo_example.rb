
require_relative '../lib/api_2captcha'

client =  Api2Captcha.new(ARGV[0])

begin
result = client.prosopo({
  pageurl: "https://www.twickets.live/",
  sitekey: "5EZVvsHMrKCFKp5NYNoTyDjTjetoVo1Z4UNNbTwJf1GfN6Xm",
})
rescue StandardError => e
    puts(e)
end


puts "Result: #{result.inspect}"