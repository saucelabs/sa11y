# Copyright (c) 2021 Sauce Labs
#
# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at
# http://mozilla.org/MPL/2.0/.

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

      analyze = Analyze.new(@driver)
      expect(number_problems(analyze)).to eq 16
    end

    it "handles frames" do
      @driver.get("http://watir.com/examples/nested_frames.html")

      analyze = Analyze.new(@driver)
      expect(number_problems(analyze)).to eq 14
    end

    it "ignores iframes when requested" do
      @driver.get("http://watir.com/examples/nested_iframes.html")

      analyze = Analyze.new(@driver, frames: false)
      expect(number_problems(analyze)).to eq 7
    end

    it "ignores frames when requested" do
      @driver.get("http://watir.com/examples/nested_frames.html")

      analyze = Analyze.new(@driver, frames: false)
      expect(number_problems(analyze)).to eq 6
    end

    def number_problems(analyze)
      analyze.results["violations"].map { |v| v["nodes"].size }.inject(0, :+)
    end
  end
end
