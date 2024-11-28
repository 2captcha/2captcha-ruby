require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.mt_captcha({
  pageurl: "https://service.mtcaptcha.com/mtcv1/demo/index.html",
  sitekey: "MTPublic-DemoKey9M"
})

puts "Result: #{result.inspect}"