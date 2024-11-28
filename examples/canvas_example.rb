require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.canvas({
  image: 'path/to/captcha.jpg',
  previous_id: 0,
  lang: 'en',
  hint_image: 'path/to/hint.jpg',
  hint_text: 'Draw around apple'
})

puts "Result: #{result.inspect}"
