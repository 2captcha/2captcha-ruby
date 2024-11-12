require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.audio({
  audio: './media/example.mp3',
  lang: "en"
})

puts "Result: #{result.inspect}"