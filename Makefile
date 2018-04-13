CWD?= $(realpath $(dir $(firstword $(MAKEFILE_LIST))))
PROJ ?= $(notdir ${CWD})

PIP:= ${CWD}/bin/pip
PYTHON:= ${CWD}/bin/python

BASE?=setuptools wheel numpy cython

.DEFAULT: venv
venv: ${PYTHON}
${PYTHON}: requirements.txt
	python3 -mvenv ${CWD}
	${PIP} install --upgrade pip
	${PIP} install --upgrade ${BASE}
	${PIP} install -r requirements.txt

.PHONY: clean
clean:
	@git clean -xfd

requirements.txt:
	@echo requirements.txt is missing.

.PHONY: lazy
lazy:
	autopep8 --in-place --aggressive --aggressive --aggressive *.py
	isort --apply *.py

.PHONY: sprint
sprint:
	/bin/sh .sprintcommit

.PHONY: debug
debug:
	$(info $${CWD}=${CWD})
	$(info $${PROJ}=${PROJ})

.PHONY: deb
deb:
	apt-get install python3 python3-venv python3-pip

