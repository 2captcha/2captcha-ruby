require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.altcha({
    pageurl: 'https://mysite.com/page/with/altcha',
    challenge: '{"algorithm":"SHA-256","challenge":"a4c9d8e7f1b23a6c...","signature":"7b3e2a9d5c8f1046e2d91c3a..."}'
    # or:
    # challenge_url: 'https://example.com/altcha-challenge'
})

puts "Result: #{result.inspect}"