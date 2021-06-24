# https://github.com/dequelabs/axe-core-maven-html/blob/61447b/src/main/java/com/deque/html/axecore/selenium/
# AxeBuilder.java#L83-L95
# Copyright (C) 2020 Deque Systems Inc.,
axe_results = """var callback = arguments[arguments.length - 1];var context = typeof arguments[0] === 'string' ?
JSON.parse(arguments[0]) : arguments[0];context = context || document; var options = JSON.parse(arguments[1]);
axe.run(context, options, function (err, results) {  {    if (err) {      throw new Error(err);    }    callback(results);  }});"""

class Analyze:

    def __init__(self, driver=None, js_lib=None):
        self.driver = driver
        self.js_lib = js_lib or open("sa11y/scripts/axe.min.js", "r").read()
        self._iframes = True

    @property
    def iframes(self):
        return self._iframes

    @iframes.setter
    def iframes(self, bool):
        self._iframes = bool

    def results(self):
        self.driver.execute_script(self.js_lib)
        if self._iframes:
            self.driver.switch_to.default_content()
            self.manage_frames()

        return self.driver.execute_async_script(axe_results, None, "{}")

    def manage_frames(self):
        frames = self.driver.find_elements_by_tag_name("iframe")
        if len(frames) == 0:
            return

        for frame in frames:
            self.driver.switch_to.frame(frame)
            self.driver.execute_script(self.js_lib)
            self.manage_frames()
            self.driver.switch_to.parent_frame()
