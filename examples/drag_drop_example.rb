require_relative "../lib/api_2captcha"

client = Api2Captcha.new(ARGV[0])

# NOTE: images below are placeholder illustrations, not a real captcha demo.
backgroundFile = File.expand_path("../media/drag_drop/background.jpeg", __FILE__)
image1File = File.expand_path("../media/drag_drop/image1.jpeg", __FILE__)
image2File = File.expand_path("../media/drag_drop/image2.jpeg", __FILE__)

backgroundStr = Base64.strict_encode64(File.binread(backgroundFile))
image1Str = Base64.strict_encode64(File.binread(image1File))
image2Str = Base64.strict_encode64(File.binread(image2File))

begin
  result = client.drag_drop({
    body: backgroundStr,
    images: [image1Str, image2Str],
    textinstructions: "Drag the images to proper position"
  })
rescue StandardError => e
  puts(e)
end

puts "Result: #{result.inspect}"
