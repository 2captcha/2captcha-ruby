require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.vkcaptcha({
  redirect_uri: 'https://id.vk.com/not_robot_captcha?domain=vk.com&session_token=eyJ....HGsc5B4LyvjA&variant=popup&blank=1',
  userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36'
})

puts "Result: #{result.inspect}"