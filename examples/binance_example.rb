
require_relative '../lib/api_2captcha'

client =  Api2Captcha.new(ARGV[0])

begin
result = client.binance({
          sitekey => "login",
          url     => "https://example.com/page-with-binance",
          validate_id => "cb0bfef...e54ecd57b"
})
rescue StandardError => e
    puts(e)
end


puts "Result: #{result.inspect}"