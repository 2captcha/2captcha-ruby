
require_relative '../lib/api_2captcha'

client = Api2Captcha.new(ARGV[0])

begin
  result = client.imperva({
    pageurl: "https://example.com/page-with-imperva",
    incapsula_script_url: "/_Incapsula_Resource?SWUDNSAI=31&xinfo=1",
    incapsula_cookies: "visid_incap_123456=sample; incap_ses_123_123456=sample",
    reese84_url_endpoint: "https://example.com/_Incapsula_Resource?reese84=1",
    userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36",
    proxytype: "http",
    proxy: "proxyuser:strongPassword@123.123.123.123:3128"
  })
rescue StandardError => e
  puts(e)
end

puts "Result: #{result.inspect}"
