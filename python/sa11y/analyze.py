axe_results = """var callback = arguments[arguments.length - 1];var context = typeof arguments[0] === 'string' ?
JSON.parse(arguments[0]) : arguments[0];context = context || document; var options = JSON.parse(arguments[1]);
axe.run(context, options, function (err, results) {  {    if (err) {      throw new Error(err);    }    callback(results);  }});"""

class Analyze:

    def __init__(self, driver=None, js_lib=None):
        self.driver = driver
        self.js_lib = js_lib or open("sa11y/scripts/axe.min.js", "r").read()

    def results(self):
        self.driver.execute_script(self.js_lib)
        return self.driver.execute_async_script(axe_results, None, "{}")
