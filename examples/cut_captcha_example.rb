require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.cutcaptcha({
  misery_key: "a1488b66da00bf332a1488993a5443c79047e752",
  api_key: "SAb83IIB",
  pageurl: "https://example.cc/foo/bar.html"
})

puts "Result: #{result.inspect}"