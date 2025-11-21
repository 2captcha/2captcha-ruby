
require_relative '../lib/api_2captcha'

client =  Api2Captcha.new(ARGV[0])

begin
result = client.temu({
  body: "path/to/image.jpg",
  part1: "path/to/part1.jpg",
  part2: "path/to/part2.jpg",
  part3: "path/to/part3.jpg",
})
rescue StandardError => e
    puts(e)
end


puts "Result: #{result.inspect}"