# frozen_string_literal: true

#how to run - API_KEY=1234567890 rspec spec/api_2captcha_spec.rb --tag initialize

RSpec.describe Api2Captcha do
  it "has a version number" do
    expect(Api2Captcha::VERSION).not_to be nil
  end

  let(:api_key)   { ENV['API_KEY'] }
  let(:client)    { Api2Captcha.new(api_key) }

  describe '#initialize', :initialize do
    it 'should set the api_key' do
      p api_key
      expect(client.api_key).to eq(api_key)
    end
  end

  describe '#normal', :normal do
    it 'should return a valid captcha result' do
      file_path = 'spec/fixtures/files/normal.jpeg'
      result = client.normal({image: file_path})
      p result
      expect(result).not_to be_nil
      #expect(result).to be_a(String)
    end
  end

  describe '#text', :text do
    it 'should return a valid text captcha result' do
      text = "If tomorrow is Saturday, what day is today?"
      lang = "en"
      result = client.text({textcaptcha: text, lang: lang})
      expect(result).not_to be_nil
      #expect(result).to be_a(String)
    end
  end

  describe '#get_balance', :get_balance do
    it 'should return the account balance' do
      balance = client.get_balance
      expect(balance).not_to be_nil
      #expect(balance).to be_a(Float)
    end
  end

  describe '#recaptcha_v2', :recaptcha_v2 do
    it 'should return a valid reCAPTCHA result' do
      url = 'https://2captcha.com/demo/recaptcha-v2'
      result = client.recaptcha_v2({
        googlekey: "site_key",
        pageurl: url,
        invisible: 1
      })
      expect(result).not_to be_nil
      #expect(result).to be_a(String)
    end
  end

  describe '#recaptcha_v3', :recaptcha_v3 do
    it 'should return a valid reCAPTCHA result' do
      url = 'http://2captcha.com/demo/recaptcha-v3'
      result = client.recaptcha_v3({
        googlekey: "site_key",
        pageurl: url,
        version: 'v3',
        score: 0.3,
        action: 'verify'
      })
      expect(result).not_to be_nil
      #expect(result).to be_a(String)
    end
  end
end




