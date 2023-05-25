# frozen_string_literal: true

require_relative "api_2captcha/version"

module Api2Captcha
  require_relative 'api_2captcha/api2captcha_exceptions'
  def self.new(*args)
    Client.new(*args)
  end
end

require 'api_2captcha/client'
