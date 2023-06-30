# frozen_string_literal: true

require_relative 'api_2captcha/api2captcha_exceptions'
require_relative 'api_2captcha/client'
require_relative 'api_2captcha/version'

module Api2Captcha
  def self.new(*args)
    Client.new(*args)
  end
end

