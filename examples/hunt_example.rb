require_relative "../lib/api_2captcha"

client = Api2Captcha.new(ARGV[0])

begin
  result = client.hunt({
                         pageurl: "https://example.com/page-with-hunt",
                         api_get_lib: "https://example.com/hd-api/external/apps/app-id/api.js",
                         userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36",
                         proxytype: "http",
                         proxy: "proxyuser:strongPassword@123.123.123.123:3128"
                       })
rescue StandardError => e
  puts(e)
end

puts "Result: #{result.inspect}"
