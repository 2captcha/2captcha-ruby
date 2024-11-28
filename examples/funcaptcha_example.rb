require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.funcaptcha({
   publickey: "69A21A01-CC7B-B9C6-0F9A-E7FA06677FFC",
   pageurl: "https://mysite.com/page/with/funcaptcha",
   surl: "https://client-api.arkoselabs.com"})

puts "Result: #{result.inspect}"