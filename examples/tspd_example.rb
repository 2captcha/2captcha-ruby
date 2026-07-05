
require_relative '../lib/api_2captcha'

client = Api2Captcha.new(ARGV[0])

begin
  result = client.tspd({
    pageurl: "https://example.com/page-with-tspd",
    tspd_cookie: "TS...",
    html_page_base64: "PGh0bWw+...",
    userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36",
    proxytype: "http",
    proxy: "proxyuser:strongPassword@123.123.123.123:3128"
  })
rescue StandardError => e
  puts(e)
end

puts "Result: #{result.inspect}"
