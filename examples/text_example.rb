require "api_2captcha"

client = Api2Captcha.new(ARGV[0])

begin
  result = client.text({
                         textcaptcha: "If tomorrow is Saturday, what day is today?",
                         lang: "en"
                       })
  puts "Result: #{result.inspect}"
rescue Api2Captcha::ValidationException => e
  # invalid parameters passed
  puts(e)
rescue Api2Captcha::NetworkException => e
  # network error occurred
  puts(e)
rescue Api2Captcha::ApiException => e
  # api respond with error
  puts(e)
rescue Api2Captcha::TimeoutException => e
  # captcha is not solved so far
  puts(e)
end
