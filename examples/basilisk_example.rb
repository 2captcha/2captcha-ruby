
require_relative '../lib/api_2captcha'

client = Api2Captcha.new(ARGV[0])

begin
  result = client.basilisk({
    pageurl: "https://example.com/page-with-basilisk",
    sitekey: "SITE_KEY"
  })
rescue StandardError => e
  puts(e)
end

puts "Result: #{result.inspect}"
