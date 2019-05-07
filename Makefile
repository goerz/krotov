.PHONY: black black-check clean clean-build clean-pyc clean-test clean-venvs coverage develop develop-docs develop-test dist dist-check docs help install isort isort-check jupyter-lab jupyter-notebook flake8-check pylint-check notebooks pre-commit-hooks release spellcheck test test-upload uninstall upload
.DEFAULT_GOAL := help
TESTENV = MATPLOTLIBRC=tests
TESTOPTIONS = --doctest-modules --cov=krotov --nbval --sanitize-with docs/nbval_sanitize.cfg --durations=10 -x -s
TESTS = src tests docs/notebooks/*.ipynb README.rst docs/*.rst
TOXOPTIONS = -vv


define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-z0-9A-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

help:  ## show this help
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: clean-build clean-pyc clean-test clean-venvs ## remove all build, test, coverage, and Python artifacts, as well as environments
	$(MAKE) -C docs clean

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	rm -fr src/*.egg-info
	rm -fr pip-wheel-metadata
	find tests src -name '*.egg-info' -exec rm -fr {} +
	find tests src -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find tests src -name '*.pyc' -exec rm -f {} +
	find tests src -name '*.pyo' -exec rm -f {} +
	find tests src -name '*~' -exec rm -f {} +
	find tests src -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -f .coverage
	rm -fr htmlcov/

clean-venvs: ## remove testing/build environments
	rm -fr .tox
	rm -fr .venv

flake8-check: ## check style with flake8
	tox $(TOXOPTIONS) -e run-flake8

pylint-check: ## check style with pylint
	tox $(TOXOPTIONS) -e run-pylint

test: ## run tests on every supported Python version
	tox $(TOXOPTIONS) -e py35-test,py36-test,py37-test

test35: ## run tests for Python 3.5
	tox $(TOXOPTIONS) -e py35-test

test36: ## run tests for Python 3.6
	tox $(TOXOPTIONS) -e py36-test

test37: ## run tests for Python 3.7
	tox $(TOXOPTIONS) -e py37-test

pre-commit-hooks: ## install pre-commit hooks
	tox $(TOXOPTIONS) -e run-cmd -- pre-commit install

docs: ## generate Sphinx HTML documentation, including API docs
	$(MAKE) -C docs clean
	tox $(TOXOPTIONS) -e docs
	@echo "open docs/_build/html/index.html"

spellcheck: ## check spelling in docs
	tox $(TOXOPTIONS) -e docs -- -b spelling

black-check: ## Check all src and test files for complience to "black" code style
	tox $(TOXOPTIONS) -e run-blackcheck

black: ## Apply 'black' code style to all src and test files
	tox $(TOXOPTIONS) -e run-blackcheck

isort-check: ## Check all src and test files for correctly sorted imports
	tox $(TOXOPTIONS) -e run-isortcheck

isort: ## Sort imports in all src and test files
	tox $(TOXOPTIONS) -e run-isort

coverage: test37  ## generate coverage report in ./htmlcov
	tox $(TOXOPTIONS) -e coverage
	@echo "open htmlcov/index.html"

test-upload: clean-build clean-pyc dist ## package and upload a release to test.pypi.org
	tox $(TOXOPTIONS) -e run-cmd -- twine check dist/*
	tox $(TOXOPTIONS) -e run-cmd -- twine upload --repository-url https://test.pypi.org/legacy/ dist/*

upload: clean-build clean-pyc dist ## package and upload a release to pypi.org
	tox $(TOXOPTIONS) -e run-cmd -- twine check dist/*
	tox $(TOXOPTIONS) -e run-cmd -- twine upload dist/*

release: ## Create a new version, package and upload it
	tox $(TOXOPTIONS) -e run-cmd -- python ./scripts/release.py

dist: ## builds source and wheel package
	tox $(TOXOPTIONS) -e run-cmd -- python setup.py sdist
	tox $(TOXOPTIONS) -e run-cmd -- python setup.py bdist_wheel
	ls -l dist

dist-check: ## Check all dist files for correctness
	tox $(TOXOPTIONS) -e run-cmd -- twine check dist/*

install: clean-build clean-pyc ## install the package to the active Python's site-packages
	pip install .

uninstall:  ## uninstall the package from the active Python's site-packages
	pip uninstall krotov

develop: clean-build clean-pyc ## install the package to the active Python's site-packages, in develop mode
	PIP_USE_PEP517=false pip install -e .

develop-test: develop ## run tests within the active Python environment
	$(TESTENV) py.test -v $(TESTOPTIONS) $(TESTS)

develop-docs: develop  ## generate Sphinx HTML documentation, including API docs, within the active Python environment
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
	@echo "open docs/_build/html/index.html"

# How to execute notebook files
%.ipynb.log: %.ipynb
	@echo ""
	tox $(TOXOPTIONS) -e run-cmd -- jupyter nbconvert --to notebook --execute --inplace --allow-errors --ExecutePreprocessor.kernel_name='python3' --config=/dev/null $< 2>&1 | tee $@

NOTEBOOKFILES = $(shell find docs/ -maxdepth 1 -iname '*.ipynb')
NOTEBOOKLOGS = $(patsubst %.ipynb,%.ipynb.log,$(NOTEBOOKFILES))

notebooks: $(NOTEBOOKLOGS)  ## re-evaluate the notebooks
	@echo ""
	@echo "All notebook are now up to date; the were executed using the python3 kernel"
	tox $(TOXOPTIONS) -e run-cmd -- jupyter kernelspec list | grep python3

jupyter-notebook: ## run a notebook server for editing the examples
	tox $(TOXOPTIONS) -e run-cmd -- jupyter notebook --config=/dev/null

jupyter-lab: ## run a jupyterlab server for editing the examples
	tox $(TOXOPTIONS) -e run-cmd -- pip install jupyterlab
	tox $(TOXOPTIONS) -e run-cmd -- jupyter lab --config=/dev/null
