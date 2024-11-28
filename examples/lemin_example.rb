require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.lemin({
  captcha_id: 'CROPPED_1abcd2f_a1234b567c890d12ef3a456bc78d901d',
  div_id: 'lemin-cropped-captcha',
  pageurl: 'https://www.site.com/page/',
  api_server: "https://api.leminnow.com/"
})

puts "Result: #{result.inspect}"