# frozen_string_literal: true

require "selenium-webdriver"

module Sa11y
  # Analyzes Current Webpage with axe™ Accessibility Tool from Deque
  class Analyze
    attr_accessor :js_lib, :frames, :cross_origin

    # https://github.com/dequelabs/axe-core-maven-html/blob/61447b/src/main/java/com/deque/html/axecore/selenium/
    # AxeBuilder.java#L83-L95
    # Copyright (C) 2020 Deque Systems Inc.,
    AXE_RUN_SCRIPT = <<~AXE
      var callback = arguments[arguments.length - 1];var context = typeof arguments[0] === 'string' ?
      JSON.parse(arguments[0]) : arguments[0];context = context || document;
      var options = JSON.parse(arguments[1]);axe.run(context, options,
      function (err, results) {  {    if (err) {      throw new Error(err);    }    callback(results);  }});
    AXE

    # https://github.com/dequelabs/axe-core-maven-html/blob/61447b/src/main/java/com/deque/html/axecore/selenium/
    # AxeBuilder.java#L97
    # Copyright (C) 2020 Deque Systems Inc.,
    IFRAME_ALLOWED_SCRIPT = "axe.configure({ allowedOrigins: ['<unsafe_all_origins>'] });"


    def initialize(driver, js_lib: nil, frames: true, cross_origin: false)
      @driver = driver
      @js_lib = js_lib || File.read(File.expand_path("../scripts/axe.min.js", __dir__))
      @frames = frames
      @cross_origin = cross_origin
    end

    def results
      if @frames
        @driver.switch_to.default_content
        manage_frames
      else
        @driver.execute_script(@js_lib)
      end
      @driver.execute_async_script(AXE_RUN_SCRIPT, nil, "{}")
    end

    private

    def manage_frames
      @driver.execute_script(@js_lib)
      @driver.execute_script(IFRAME_ALLOWED_SCRIPT) if @cross_origin

      frame_elements = @driver.find_elements(xpath: ".//*[local-name()='frame' or local-name()='iframe']")

      frame_elements.each do |frame|
        @driver.switch_to.frame(frame)
        manage_frames
        @driver.switch_to.parent_frame
      end
    end
  end
end
