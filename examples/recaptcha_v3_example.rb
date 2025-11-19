require_relative '../lib/api_2captcha'

client =  Api2Captcha.new(ARGV[0])

begin
result = client.recaptcha_v3({
                               googlekey: "6LfD3PIbAAAAAJs_eEHvoOl75_83eXSqpPSRFJ_u",
                               pageurl: "http://2captcha.com/demo/recaptcha-v3",
                               version: "v3",
                               score: 0.3,
                               action: "verify"
                             })
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


puts "Result: #{result.inspect}"