require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.geetest({
  gt: 'f1ab2cdefa3456789012345b6c78d90e',
  api_server: 'api-na.geetest.com',
  challenge: '12345678abc90123d45678ef90123a456b',
  pageurl: 'https://www.site.com/page/'
})

puts "Result: #{result.inspect}"