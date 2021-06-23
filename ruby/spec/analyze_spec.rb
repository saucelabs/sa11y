# frozen_string_literal: true

require "spec_helper"

module Sa11y
  describe Analyze do
    before { @driver = Selenium::WebDriver.for :chrome }
    after { @driver.quit }

    it "analyzes" do
      results = Analyze.new(@driver).results

      expect(results["violations"]).not_to be_empty
    end

    it "accepts a different axe.js file" do
      analyze = Analyze.new(@driver, js_lib: File.read("spec/resources/old.axe.min.js"))

      results = analyze.results
      expect(results.dig("testEngine", "version")).to eq "3.5.3"
    end

    it "handles iframes" do
      @driver.get("http://watir.com/examples/nested_iframes.html")

      expect_any_instance_of(Selenium::WebDriver::Driver)
        .to receive(:switch_to).exactly(7).times.and_call_original

      Analyze.new(@driver).results
    end

    it "ignores iframes when requested" do
      analyze = Analyze.new(@driver)
      analyze.iframes = false

      @driver.get("http://watir.com/examples/iframes.html")

      expect_any_instance_of(Selenium::WebDriver::Driver).not_to receive(:switch_to)
      analyze.results
    end
  end
end
