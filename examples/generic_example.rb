require_relative "../lib/api_2captcha"

client = Api2Captcha.new(ARGV[0])

client = Api2Captcha.generic_client("YOUR_API_KEY")

result = client.text({
                       textcaptcha: "If tomorrow is Saturday, what day is today?",
                       lang: "en"
                     })

puts "Result: #{result.inspect}"
