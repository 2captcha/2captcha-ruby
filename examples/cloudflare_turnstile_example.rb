require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.turnstile({
  sitekey: "0x0AAAAAAADnPIDROzbs0Aaj",
  data: "7fab0000b0e0ff00",
  pagedata: "3gAFo2...0ME1UVT0=",
  pageurl: "https://2captcha.com/",
  action: "managed",
  userAgent: "Mozilla/5.0 ... Chrome/116.0.0.0 Safari/537.36",
  json: 1
})

puts "Result: #{result.inspect}"