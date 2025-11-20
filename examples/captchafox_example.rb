
require_relative '../lib/api_2captcha'

client =  Api2Captcha.new(ARGV[0])

begin
  result = client.captchafox({
        sitekey: "sk_vKdD8WGlPF5FKpRDs1U4qTuu6Jv0w",
        pageurl: "https://sinscrire.gmx.fr/",
        userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
        proxytype: "socks5",
        proxy: "u37d88e6957ca05d6-zone-custom-region-fr:u37d88e6957ca05d6@118.193.59.17:10743"
               })

rescue StandardError => e
    puts(e)
end

puts "Result: #{result.inspect}"