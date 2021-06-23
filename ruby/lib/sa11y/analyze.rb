# frozen_string_literal: true

require "selenium-webdriver"

module Sa11y
  # Analyzes Current Webpage with axe™ Accessibility Tool from Deque
  class Analyze
    attr_accessor :js_lib

    # https://github.com/dequelabs/axe-core-maven-html/blob/61447b/src/main/java/com/deque/html/axecore/selenium/
    # AxeBuilder.java#L83-L95
    # Copyright (C) 2020 Deque Systems Inc.,
    AXE_RESULTS = <<~AXE
      var callback = arguments[arguments.length - 1];var context = typeof arguments[0] === 'string' ?
      JSON.parse(arguments[0]) : arguments[0];context = context || document;
      var options = JSON.parse(arguments[1]);axe.run(context, options,
      function (err, results) {  {    if (err) {      throw new Error(err);    }    callback(results);  }});
    AXE

    def initialize(driver, js_lib: nil)
      @driver = driver
      @js_lib = js_lib || File.read(File.expand_path('../../scripts/axe.min.js', __FILE__))
    end

    def results
      @driver.execute_script(@js_lib)
      @driver.execute_async_script(AXE_RESULTS, nil, "{}")
    end
  end
end
