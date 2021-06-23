# frozen_string_literal: true

require "selenium-webdriver"

module Sa11y
  # Analyzes Current Webpage with axe™ Accessibility Tool from Deque
  class Analyze
    # https://github.com/dequelabs/axe-core-maven-html/blob/61447b/src/main/java/com/deque/html/axecore/selenium/
    # AxeBuilder.java#L83-L95
    # Copyright (C) 2020 Deque Systems Inc.,
    AXE_RESULTS = <<~AXE
      var callback = arguments[arguments.length - 1];var context = typeof arguments[0] === 'string' ?
      JSON.parse(arguments[0]) : arguments[0];context = context || document;
      var options = JSON.parse(arguments[1]);axe.run(context, options,
      function (err, results) {  {    if (err) {      throw new Error(err);    }    callback(results);  }});
    AXE

    def initialize(driver)
      @driver = driver
    end

    def results
      js_lib = File.read("lib/scripts/axe.min.js")
      @driver.execute_script(js_lib)
      @driver.execute_async_script(AXE_RESULTS, nil, "{}")
    end
  end
end
