
require_relative '../lib/api_2captcha'

client =  Api2Captcha.new(ARGV[0])

body = File.expand_path("../media/temu/body.png", FILE)
part1 = File.expand_path("../media/temu/part1.png", FILE)
part2 = File.expand_path("../media/temu/part2.png", FILE)
part3 = File.expand_path("../media/temu/part3.png", FILE)

begin
result = client.temu({
  body: body,
  part1: part1,
  part2: part2,
  part3: part3,
})
rescue StandardError => e
    puts(e)
end


puts "Result: #{result.inspect}"