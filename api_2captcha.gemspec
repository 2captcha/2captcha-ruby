# frozen_string_literal: true

require_relative "lib/api_2captcha/version"

Gem::Specification.new do |spec|
  spec.name = "ruby-2captcha"
  spec.version = Api2Captcha::VERSION
  spec.authors = ["2captcha.com"]
  spec.email = ["info@2captcha.com"]

  spec.summary = "2Captcha API wrapper for Ruby."
  spec.description = "Ruby package for easy integration with the API of 2captcha captcha solving service to bypass recaptcha, hcaptcha, funcaptcha, geetest and solve any other captchas."
  spec.homepage = "https://2captcha.com/"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/2captcha/2captcha-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/2captcha/2captcha-ruby/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
