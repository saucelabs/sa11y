from sa11y.analyze import Analyze
from selenium import webdriver


class TestInit(object):

    def test_analysis(self):
        driver = webdriver.Chrome()
        results = Analyze(driver).results()

        assert not len(results.get('violations', None)) == 0, "No violations found"

    def test_different_js(self):
        driver = webdriver.Chrome()
        js_lib = open("tests/resources/old.axe.min.js", "r").read()
        results = Analyze(driver, js_lib=js_lib).results()

        assert results.get('testEngine', None).get('version', None) == "3.5.3", "Wrong version found"

    def test_iframes(self):
        driver = webdriver.Chrome()
        driver.get("http://watir.com/examples/iframes.html")

        results = Analyze(driver).results()
        assert len(results.get('violations', None)) == 5, "No violations found"

    def test_toggle_off_iframes(self):
        driver = webdriver.Chrome()
        driver.get("http://watir.com/examples/iframes.html")

        analyze = Analyze(driver)
        analyze.iframes = False
        results = analyze.results()
        assert len(results.get('violations', None)) == 3, "No violations found"
