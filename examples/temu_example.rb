
require_relative '../lib/api_2captcha'

client =  Api2Captcha.new(ARGV[0])

bodyFile = File.expand_path("../media/temu/body.png", __FILE__)
part1File = File.expand_path("../media/temu/part1.png", __FILE__)
part2File = File.expand_path("../media/temu/part2.png", __FILE__)
part3File = File.expand_path("../media/temu/part3.png", __FILE__)

bodyStr = Base64.strict_encode64(File.binread(bodyFile))
part1Str = Base64.strict_encode64(File.binread(part1File))
part2Str = Base64.strict_encode64(File.binread(part2File))
part3Str = Base64.strict_encode64(File.binread(part3File))

begin
result = client.temu({
  body: bodyStr,
  part1: part1Str,
  part2: part2Str,
  part3: part3Str,
})
rescue StandardError => e
    puts(e)
end


puts "Result: #{result.inspect}"