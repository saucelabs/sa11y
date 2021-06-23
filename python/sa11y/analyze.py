axe_results = """var callback = arguments[arguments.length - 1];var context = typeof arguments[0] === 'string' ?
JSON.parse(arguments[0]) : arguments[0];context = context || document; var options = JSON.parse(arguments[1]);
axe.run(context, options, function (err, results) {  {    if (err) {      throw new Error(err);    }    callback(results);  }});"""

class Analyze:

    def __init__(self, driver=None):
        self.driver = driver

    def results(self):
        js_lib = open("sa11y/scripts/axe.min.js", "r").read()

        self.driver.execute_script(js_lib)
        return self.driver.execute_async_script(axe_results, None, "{}")
