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
  end
end
