VSN=1.3.2
SERVICE=cloudi_service_tmpo

PATH_PREFIX=/usr/local
CORE_PATH=$(PATH_PREFIX)/lib/cloudi-$(VSN)/lib/cloudi_core-$(VSN)

HOST=localhost
PORT=6467
URL_PREFIX=http://$(HOST):$(PORT)/cloudi/api/erlang

PWD=$(shell pwd)
UUID=<<>>

compile:
	MIX_ENV=prod mix compile

clean:
	mix clean

start:
	@curl -X POST -d '"'$(PATH_PREFIX)/lib/elixir/lib/elixir/ebin'"' $(URL_PREFIX)/code_path_add
	@echo
	@curl -X POST -d '"'$(PWD)/_build/prod/lib/$(SERVICE)/ebin'"' $(URL_PREFIX)/code_path_add
	@echo
	@curl -X POST -d @$(SERVICE).conf $(URL_PREFIX)/services_add
	@echo

restart:
	@curl -X POST -d "[$(UUID)]" $(URL_PREFIX)/services_restart
	@echo

stop:
	@curl -X POST -d "[$(UUID)]" $(URL_PREFIX)/services_remove 
	@echo

help:
	@echo 'You need to have cloudi running (check with cloudi ping).'
	@echo 'Makefile targets:'
	@echo ' compile'
	@echo ' clean'
	@echo ' start'
	@echo ' restart UUID="<<...>>"'
	@echo ' stop UUID="<<...>>"'

.PHONY: compile clean start restart stop help
