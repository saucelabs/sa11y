# frozen_string_literal: true

require_relative "lib/sa11y/version"

Gem::Specification.new do |spec|
  spec.name          = "sa11y"
  spec.version       = Sa11y::VERSION
  spec.authors       = ["titusfortner"]
  spec.email         = ["titusfortner@gmail.com"]

  spec.summary       = "The Selenium Accessibility Gem"
  spec.description   = "Get basic accessibility information using" \
    "the axe-core npm library (https://www.npmjs.com/package/axe-core)" \
    "on websites visited using Selenium (https://www.selenium.dev)."
  spec.homepage = "https://github.com/saucelabs/sa11y"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/saucelabs/sa11y/blob/main/ruby/"
  spec.metadata["changelog_uri"] = "https://github.com/saucelabs/sa11y/blob/main/ruby/CHANGELOG.md"

  spec.files = %w[LICENSE.md Gemfile README.md Rakefile sa11y.gemspec] + Dir["lib/sa11y/**/*"] + Dir["lib/scripts/*"]

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rake", "~> 13.0"
  spec.add_dependency "rspec", "~> 3.0"
  spec.add_dependency "rubocop", "~> 1.7"
  spec.add_dependency "selenium-webdriver", ">= 3.142.7"
end
