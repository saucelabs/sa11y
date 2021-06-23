# frozen_string_literal: true

require "spec_helper"

module Sa11y
  describe Analyze do
    after { @driver.quit }

    it "analyzes" do
      @driver = Selenium::WebDriver.for :chrome
      results = Analyze.new(@driver).results

      expect(results["violations"]).not_to be_empty
    end
  end
end
