SHELL:=/bin/bash
CWD:=$(shell pwd)

bootstrap:
	$(CWD)/setup/bootstrap.sh
install:
	$(CWD)/setup/install.sh 
