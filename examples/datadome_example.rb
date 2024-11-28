require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.data_dome({
  pageurl: "https://test.com",
  captcha_url: "https://test.com/captcha/",
  proxytype: "http",
  proxy: "proxyuser:strongPassword@123.123.123.123:3128"
})

puts "Result: #{result.inspect}"