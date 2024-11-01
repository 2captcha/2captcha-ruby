require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.recaptcha_v2({
  googlekey: '6LfD3PIbAAAAAJs_eEHvoOl75_83eXSqpPSRFJ_u',
  pageurl: 'https://2captcha.com/demo/recaptcha-v2',
})

puts "Result: #{result.inspect}"