.PHONY: run setup push
SHELL := /bin/bash

all: run

run:
	scripts/app.sh

setup:
	scripts/setup.sh

push: setup
	cf push
