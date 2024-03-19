#!/usr/bin/env make

.DEFAULT_GOAL := default

.PHONY: check clean help run

PYTHON	:= $(shell which python3)
CTAGS	:= $(shell which ctags)
LINE_LENGTH	:= 79	# PEP-8 standards ensure styling tools use this too

SRCS	:= $(wildcard library/*.py)
YAMLS	:= $(wildcard *.yaml roles/simple/tasks/main.yaml)

default:	check run

all:	default

help:
	@echo
	@echo "Default goal: ${.DEFAULT_GOAL}"
	@echo "  all:     check cover run test doc dist"
	@echo "  check:   check style and lint code"
	@echo "  run:	  run main with example arguments"
	@echo "  clean:   delete all generated files"
	@echo
	@echo "Initialise virtual environment (venv) with:"
	@echo
	@echo "pip3 install virtualenv; python3 -m virtualenv .venv; source .venv/bin/activate; pip3 install -Ur requirements.txt"
	@echo
	@echo "Start virtual environment (.venv) with:"
	@echo
	@echo "source .venv/bin/activate"
	@echo
	@echo "Deactivate with:"
	@echo
	@echo "deactivate"
	@echo

check:
ifdef CTAGS
	# ctags for vim
	ctags --recurse -o tags $(SRCS)
endif
	# sort imports
	isort --line-length $(LINE_LENGTH) --profile black $(SRCS)
	# format code to googles style
	black --quiet --line-length $(LINE_LENGTH) $(SRCS)
	# sort requirements
	sort-requirements requirements.txt
	# check with flake8
	flake8 $(SRCS)
	# check with pylint
	pylint $(SRCS)
	# check yaml
	yamllint --strict $(YAMLS)
	# check ansible
	ansible-lint site.yaml

run:
	ansible-playbook site.yaml

clean:
	$(RM) -rf public/
	$(RM) -rf __pycache__ pages-report/__pycache__
	$(RM) -v *.pyc *.pyo *.py,cover
	$(RM) -v **/*.pyc **/*.pyo **/*.py,cover
