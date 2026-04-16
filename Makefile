SHELL:=/bin/bash
CWD:=$(shell pwd)

.PHONY: bootstrap
bootstrap:
	$(CWD)/setup/bootstrap.sh

.PHONY: install
install:
	$(CWD)/setup/install.sh

.PHONY: hooks
hooks:
	pre-commit install
	pre-commit install --hook-type commit-msg

.PHONY: hooks-run
hooks-run:
	pre-commit run --all-files
