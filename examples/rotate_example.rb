require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.rotate({
  image: 'path/to/captcha.jpg',
  angle: 40,
  lang: 'en',
  hint_image: 'path/to/hint.jpg',
  hint_text: 'Put the images in the correct way'
})

puts "Result: #{result.inspect}"