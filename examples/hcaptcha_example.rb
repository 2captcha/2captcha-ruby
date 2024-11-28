require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.hcaptcha({
  sitekey: '10000000-ffff-ffff-ffff-000000000001',
  pageurl: 'https://www.site.com/page/'
})

puts "Result: #{result.inspect}"