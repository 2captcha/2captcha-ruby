require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.text({
  textcaptcha:'If tomorrow is Saturday, what day is today?',
  lang: "en"
})

puts "Result: #{result.inspect}"