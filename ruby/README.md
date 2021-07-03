# Sa11y

The Selenium Accessibility Gem

Get basic accessibility information using
the [axe-core npm library](https://www.npmjs.com/package/axe-core)
on websites visited using [Selenium](https://www.selenium.dev/).

Contact [Deque](https://www.deque.com/) for more information about axe™ functionality and results.

Note: This project does not support all the features available in axe™, but is
provided for the flexibility and convenience of Ruby Selenium users. 

### Prerequisites

You should have a working Ruby environment on your machine and be able to execute Selenium code. 

Note that the `webdrivers` gem automatically downloads the required driver for the requested browser
as well as requires the `selenium-webdriver` gem so that doesn't have to be specified in this code.
```shell
$ gem install webdrivers
$ irb
```
```ruby
require 'webdrivers'
Selenium::WebDriver.for(:chrome).quit
```

## Installing

Add this line to your application's Gemfile:
```ruby
gem 'sa11y'
```

And then execute this in your application's directory:
```shell
$ bundle install
```

Or install it on your machine with:
```shell
$ gem install sa11y
```

## Usage

Using this gem in your code just requires you to pass in a valid driver instance to the `Analyze` class constructor
and call the `#results` method.
```ruby
driver = Selenium::WebDriver.for :chrome 
Sa11y::Analyze(driver).results
```

By default, sa11y inspects elements in all frames and iframes on the page.
If your site does not use frames, you can improve performance slightly by turning off frame checks:
```ruby
driver = Selenium::WebDriver.for :chrome
analyze = Sa11y::Analyze(driver, frames: false)
analyze.results
```

By default, sa11y does not inspect frames from cross origins. If you need to analyze frames
originating from a different domain, you need to turn this on:
```ruby
driver = Selenium::WebDriver.for :chrome
analyze = Sa11y::Analyze(driver, cross_origin: true)
analyze.results
```

This gem comes packaged with the latest axe™ version at release. If you want to change this, 
specify the JS library you want to use:
```ruby
driver = Selenium::WebDriver.for :chrome
Sa11y::Analyze(driver, js_lib: File.read("path/to/axe.min.js"))
analyze.results
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

## Deployment

The gem needs to include a dynamically generated `axe.min.js` file, and can be built and deployed with these commands:

```shell
$ bundle exec rake build_gem
$ bundle exec rake release
```

This creates a git tag for the version, pushes both the git commits and the created tag,
and publishes the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Please read [CONTRIBUTING.md](../CONTRIBUTING.md) for details on our process for submitting pull requests to us,
and please ensure you follow the [CODE_OF_CONDUCT.md](../CODE_OF_CONDUCT.md).

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available,
see the [tags on this repository](https://github.com/saucelabs/sa11y/tags).

## License and Copyright

This project is licensed under the MPL-2.0 License - see the [LICENSE.md](LICENSE.md) file for details
Copyright (c) 2021 Sauce Labs

## Acknowledgments

* Thanks to [@dequelabs](https://github.com/dequelabs) for their contributions to accessibility with the axe™ project
* Thanks to [@seleniumhq](https://github.com/seleniumhq) for their contributions to browser automation with the Selenium project
