require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.coordinates({
  image: 'path/to/captcha.jpg',
  lang: 'en',
  hint_image: 'path/to/hint.jpg',
  hint_text: 'Connect the dots'
})

puts "Result: #{result.inspect}"