from sa11y.analyze import Analyze
from selenium import webdriver


def numberProblems(analyze):
    violations = analyze.results().get('violations')
    return sum(list(map(lambda x: len(x.get("nodes")), violations)))

class TestInit(object):

    def test_analysis(self):
        driver = webdriver.Chrome()
        results = Analyze(driver).results()

        assert not len(results.get('violations', None)) == 0, "No violations found"

    def test_different_js(self):
        driver = webdriver.Chrome()
        js_lib = open("../tests/resources/old.axe.min.js", "r").read()
        results = Analyze(driver, js_lib=js_lib).results()

        assert results.get('testEngine', None).get('version', None) == "3.5.3", "Wrong version found"

    def test_iframes(self):
        driver = webdriver.Chrome()
        driver.get("http://watir.com/examples/nested_iframes.html")

        analyze = Analyze(driver)
        assert numberProblems(analyze) == 16, "Wrong number of violations found"

    def test_frames(self):
        driver = webdriver.Chrome()
        driver.get("http://watir.com/examples/nested_frames.html")

        analyze = Analyze(driver)

        assert numberProblems(analyze) == 14, "Wrong number of violations found"

    def test_toggle_off_frames_for_iframes(self):
        driver = webdriver.Chrome()
        driver.get("http://watir.com/examples/nested_iframes.html")

        analyze = Analyze(driver, frames=False)
        assert numberProblems(analyze) == 7, "Wrong number of violations found"

    def test_toggle_off_frames_for_Frames(self):
        driver = webdriver.Chrome()
        driver.get("http://watir.com/examples/nested_frames.html")

        analyze = Analyze(driver, frames=False)
        assert numberProblems(analyze) == 6, "Wrong number of violations found"
