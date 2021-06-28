Sa11y
==========================

The Selenium Accessibility Package

Get basic accessibility information using
the `axe-core npm library <https://www.npmjs.com/package/axe-core>`_
on websites visited using `Selenium <https://www.selenium.dev>`_.

Contact `Deque <https://www.deque.com>`_ for more information about axe™ functionality and results.

Note: This project does not support all of the features available in axe™, but is
provided for the flexibility and convenience of Ruby users.


Prerequisites
--------------

* Install `python`
* Install `pip`
* Install `npm`

Installing
--------------

    $ pip install sa11y

Usage
-------------

Just pass in a valid driver instance to the `Analyze` class constructor and call the `#results` method.

    driver = webdriver.Chrome()
    Analyze(driver).results()

If your site does not use iFrames, you can improve performance slightly by turning off iframe checks:

    driver = webdriver.Chrome()
    analyze = Analyze(driver)
    analyze.iframes = False
    analyze.results()

This gem comes packaged with the latest axe™ version at release. If you want to change this, specify the JS library you want to use:

    driver = webdriver.Chrome()
    js_lib = open("tests/resources/old.axe.min.js", "r").read()
    Analyze(driver, js_lib=js_lib).results()

Development
-------------

This project will be developed in Python 3.x so please create a
`virtual environment <https://pip.pypa.io/en/stable/>`_:

    python3 -m venv venv

    source venv/bin/activate

To install dependencies, do the following:

    pip install -r requirements.txt

To install required scripts:

    python setup.py npm_install


Deployment
-------------

The project needs to include a dynamically generated `axe.min.js` file, and can be built with this command:

    python setup.py npm_install install

Contributing
-------------

Please read [CONTRIBUTING.md](../CONTRIBUTING.md) for details on our process for submitting pull requests to us,
and please ensure you follow the [CODE_OF_CONDUCT.md](../CODE_OF_CONDUCT.md).

Versioning
-------------

We use [SemVer](http://semver.org/) for versioning. For the versions available,
see the [tags on this repository](https://github.com/saucelabs/sa11y/tags).

License
-------------

This project is licensed under the MPL-2.0 License - see the [LICENSE.md](LICENSE.md) file for details

Acknowledgments
-------------

* Thanks to [@dequelabs](https://github.com/dequelabs) for their contributions to accessibility with the axe™ project
* Thanks to [@seleniumhq](https://github.com/seleniumhq) for their contributions to browser automation with the Selenium project

Testing
---------

To run all tests, run the following:

    pytest
