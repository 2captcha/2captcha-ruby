require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.friendly({
  pageurl: "https://example.com",
  sitekey: "2FZFEVS1FZCGQ9"
})

puts "Result: #{result.inspect}"