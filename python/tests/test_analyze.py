from sa11y.analyze import Analyze
from selenium import webdriver


class TestInit(object):

    def test_analysis(self):
        driver = webdriver.Chrome()
        results = Analyze(driver).results()

        assert not len(results.get('violations', None)) == 0, "No violations found"

