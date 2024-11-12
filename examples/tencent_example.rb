require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.tencent({
  app_id: "197326679",
  pageurl: "https://mysite.com/page/with/tencent"
})

puts "Result: #{result.inspect}"