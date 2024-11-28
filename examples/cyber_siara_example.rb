require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.cyber_siara({
  pageurl: "https://test.com",
  master_url_id: "12333-3123123"
})

puts "Result: #{result.inspect}"