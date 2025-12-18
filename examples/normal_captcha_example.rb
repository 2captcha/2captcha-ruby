require 'api_2captcha'

client =  Api2Captcha.new(ARGV[0])

image_absolute_path = File.expand_path("../media/normal_2.jpg", __FILE__)

result = client.normal({
  image: image_absolute_path,
})

puts "Result: #{result.inspect}"