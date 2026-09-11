# frozen_string_literal: true

require_relative "api_2captcha/api2captcha_exceptions"
require_relative "api_2captcha/client"
require_relative "api_2captcha/version"
require_relative "api_2captcha/generic_client"

module Api2Captcha
  def self.new(*args)
    Client.new(*args)
  end

  def self.generic_client(*args)
    GenericClient.new(*args)
  end
end
