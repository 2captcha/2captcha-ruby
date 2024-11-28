require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.yandex({
  sitekey: 'Y5Lh0tiycconMJGsFd3EbbuNKSp1yaZESUOIHfeV',
  url: "https://rutube.ru"
})

puts "Result: #{result.inspect}"