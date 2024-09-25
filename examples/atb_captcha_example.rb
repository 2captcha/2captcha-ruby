require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")

result = client.atb_captcha({
  app_id: "197326679",
  api_server: "api.atb_captcha.com",
  pageurl: "https://mysite.com/page/with/atb_captcha"
})