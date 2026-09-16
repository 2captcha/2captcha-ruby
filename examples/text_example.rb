require "api_2captcha"

client = Api2Captcha.new(ARGV[0])

result = client.text({
                       textcaptcha: "If tomorrow is Saturday, what day is today?",
                       lang: "en"
                     })

puts "Result: #{result.inspect}"
