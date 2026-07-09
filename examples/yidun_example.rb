
require_relative '../lib/api_2captcha'

client = Api2Captcha.new(ARGV[0])

begin
  result = client.yidun({
    pageurl: "https://example.com/page-with-yidun",
    sitekey: "SITE_KEY"
  })
rescue StandardError => e
  puts(e)
end

puts "Result: #{result.inspect}"
