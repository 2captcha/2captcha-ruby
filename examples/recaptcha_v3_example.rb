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
rescue StandardError => e
    puts(e)
end


puts "Result: #{result.inspect}"