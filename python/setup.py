from setuptools import Command
from setuptools import setup, find_packages

class NPMInstall(Command):
    user_options = []

    def initialize_options(self):
        pass

    def finalize_options(self):
        pass

    def run(self):
        self.spawn(['npm', 'install'])
        self.spawn(['rm', '-rf', 'sa11y/scripts'])
        self.spawn(['mkdir', 'sa11y/scripts'])
        self.spawn(['cp', 'node_modules/axe-core/axe.min.js', 'sa11y/scripts/'])

with open('./README.rst', 'r') as f:
  readme = f.read()

setup(
    cmdclass={
        'npm_install': NPMInstall
    },
    name='sa11y',
    version='0.2.3',
    packages=find_packages(include=['sa11y', 'sa11y.*']),
    python_requires='>=3',
    url='https://github.com/saucelabs/sa11y',
    license='MPL-2.0',
    description='The Selenium Accessibility Project',
    long_description=readme,
    long_description_content_type="text/x-rst",
    author='titusfortner',
    author_email='titusfortner@gmail.com',
    keywords=['selenium', 'testing', 'accessibility', 'Deque', 'axe'],
    install_requires=[
        'selenium',
        'pytest'
    ],
    package_data={
        'sa11y': ['scripts/axe.min.js'],
    },
)
