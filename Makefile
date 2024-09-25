SHELL:=/bin/bash
CWD:=$(shell pwd)

.PHONY: bootstrap
bootstrap:
	$(CWD)/setup/bootstrap.sh

.PHONY: install
install:
	$(CWD)/setup/install.sh 
