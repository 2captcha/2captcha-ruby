require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.vkcaptcha({
  image: '/9j/4AAQSkZJRgABAQAAAQABAAD/2...',
  steps: '[5,19,14,14,6,4,8...]'
})

puts "Result: #{result.inspect}"