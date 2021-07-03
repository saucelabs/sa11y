# Copyright (c) 2021 Sauce Labs
#
# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at
# http://mozilla.org/MPL/2.0/.

import os

# https://github.com/dequelabs/axe-core-maven-html/blob/61447b/src/main/java/com/deque/html/axecore/selenium/
# AxeBuilder.java#L83-L95
# Copyright (C) 2020 Deque Systems Inc.,
axe_run_script = """var callback = arguments[arguments.length - 1];var context = typeof arguments[0] === 'string' ?
JSON.parse(arguments[0]) : arguments[0];context = context || document; var options = JSON.parse(arguments[1]);
axe.run(context, options, function (err, results) {  {    if (err) {      throw new Error(err);    }    callback(results);  }});"""

# https://github.com/dequelabs/axe-core-maven-html/blob/61447b/src/main/java/com/deque/html/axecore/selenium/
# AxeBuilder.java#L97
# Copyright (C) 2020 Deque Systems Inc.,
iframe_allowed_script = "axe.configure({ allowedOrigins: ['<unsafe_all_origins>'] });"

class Analyze:

    def __init__(self, driver, js_lib=None, frames=True, cross_origin=False):
        self.driver = driver
        self._js_lib = js_lib or open(os.path.join(os.path.dirname(__file__), "scripts/axe.min.js"), "r").read()
        self._frames = frames
        self._cross_origin = cross_origin

    @property
    def frames(self):
        return self._frames

    @frames.setter
    def frames(self, frames):
        self._frames = frames

    @property
    def js_lib(self):
        return self._js_lib

    @js_lib.setter
    def js_lib(self, js_lib):
        self._js_lib = js_lib

    @property
    def cross_origin(self):
        return self._cross_origin

    @cross_origin.setter
    def cross_origin(self, cross_origin):
        self._cross_origin = cross_origin

    def results(self):
        if self._frames:
            self.driver.switch_to.default_content()
            self.manage_frames()
        else:
            self.driver.execute_script(self._js_lib)

        return self.driver.execute_async_script(axe_run_script, None, "{}")

    def manage_frames(self):
        self.driver.execute_script(self._js_lib)
        if self._cross_origin:
            self.driver.execute_script(iframe_allowed_script)
        frames = self.driver.find_elements_by_xpath(".//*[local-name()='frame' or local-name()='iframe']")

        for frame in frames:
            self.driver.switch_to.frame(frame)
            self.manage_frames()
            self.driver.switch_to.parent_frame()
