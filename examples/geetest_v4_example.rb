require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.geetest_v4({
  captcha_id: 'e392e1d7fd421dc63325744d5a2b9c73',
  pageurl: 'https://www.site.com/page/'
})

puts "Result: #{result.inspect}"