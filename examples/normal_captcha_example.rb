require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.normal({
  image: './media/normal_2.jpg',
})

puts "Result: #{result.inspect}"