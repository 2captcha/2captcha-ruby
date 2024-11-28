require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.capy({
  sitekey: 'PUZZLE_Abc1dEFghIJKLM2no34P56q7rStu8v',
  pageurl: 'http://mysite.com/',
  api_server: 'https://jp.api.capy.me/'
})

puts "Result: #{result.inspect}"