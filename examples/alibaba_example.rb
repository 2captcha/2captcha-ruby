
require_relative '../lib/api_2captcha'

client = Api2Captcha.new(ARGV[0])

begin
  result = client.alibaba({
    pageurl: "https://example.com/page-with-alibaba",
    scene_id: "SCENE_ID",
    prefix: "PREFIX"
  })
rescue StandardError => e
  puts(e)
end

puts "Result: #{result.inspect}"
