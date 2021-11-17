#!/usr/bin/env make

.DEFAULT_GOAL := check

.PHONY: check clean help

PYTHON	:= /usr/bin/python3

SRCS	:= library/*.py
YAMLS	:= $(wildcard *.yaml roles/**/*.yaml)

all: check test run doc dist

help:
	@echo
	@echo "Default goal: ${.DEFAULT_GOAL}"
	@echo "  all:   	check cover run test doc dist"
	@echo "  check: 	check style and lint code"
	@echo "  clean: 	delete all generated files"
	@echo "  exec:		run main with example arguments"
	@echo "  version:	show version"
	@echo
	@echo "Initialise virtual environment (venv) with:"
	@echo
	@echo "pip3 install virtualenv; python3 -m virtualenv venv; source venv/bin/activate; pip3 install -Ur requirements.txt"
	@echo
	@echo "Start virtual environment (venv) with:"
	@echo
	@echo "source venv/bin/activate"
	@echo
	@echo "Deactivate with:"
	@echo
	@echo "deactivate"
	@echo

check:
	# sort imports
	isort $(SRCS)
	# format code to googles style
	yapf --style google --parallel -i $(SRCS)
	# lint
	pylint $(SRCS)
	# check yaml
	yamllint --strict $(YAMLS)
	# check ansible
	ansible-lint site.yaml

exec:
	ansible-playbook site.yaml

clean:
	$(RM) -rf public/
	$(RM) -rf __pycache__ pages-report/__pycache__
	$(RM) -v *.pyc *.pyo *.py,cover
	$(RM) -v **/*.pyc **/*.pyo **/*.py,cover
