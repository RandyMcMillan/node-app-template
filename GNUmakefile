THIS_FILE                               := $(lastword $(MAKEFILE_LIST))
export THIS_FILE
TIME                                    := $(shell date +%s)
export TIME
OS                                      :=$(shell uname -s)
export OS
OS_VERSION                              :=$(shell uname -r)
export OS_VERSION
ARCH                                    :=$(shell uname -m)
export ARCH
ifeq ($(ARCH),x86_64)
TRIPLET                                 :=x86_64-linux-gnu
export TRIPLET
endif
ifeq ($(ARCH),arm64)
TRIPLET                                 :=aarch64-linux-gnu
export TRIPLET
endif
ifeq ($(ARCH),arm64)
TRIPLET                                 :=aarch64-linux-gnu
export TRIPLET
endif
SHELL                                   := /bin/bash
POWERSHELL                              := $(shell which pwsh)
PWD                                     ?= pwd_unknown
CMAKE                                   :=$(shell which cmake)
export CMAKE

NODE_VERSION                            := v16.19.1
export NODE_VERSION
NODE_ALIAS                              := v16.19.0
export NODE_ALIAS

ifeq ($(docker),)
DOCKER                                  := $(shell which docker)
endif
export DOCKER

ifneq ($(shell docker-compose),)
DOCKER_COMPOSE                          := $(shell which docker-compose)
else
DOCKER_COMPOSE                          := $(shell $(DOCKER) compose)
endif
export DOCKER_COMPOSE

PYTHON                                  := $(shell which python)
export PYTHON
PYTHON2                                 := $(shell which python2)
export PYTHON2
PYTHON3                                 := $(shell which python3)
export PYTHON3

PIP                                     := $(shell which pip)
export PIP
PIP2                                    := $(shell which pip2)
export PIP2
PIP3                                    := $(shell which pip3)
export PIP3

python_version_full := $(wordlist 2,4,$(subst ., ,$(shell python3 --version 2>&1)))
python_version_major := $(word 1,${python_version_full})
python_version_minor := $(word 2,${python_version_full})
python_version_patch := $(word 3,${python_version_full})

my_cmd.python.3 := $(PYTHON3) some_script.py3
my_cmd := ${my_cmd.python.${python_version_major}}

PYTHON_VERSION                          := ${python_version_major}.${python_version_minor}.${python_version_patch}
PYTHON_VERSION_MAJOR                    := ${python_version_major}
PYTHON_VERSION_MINOR                    := ${python_version_minor}

export python_version_major
export python_version_minor
export python_version_patch
export PYTHON_VERSION

#PROJECT_NAME defaults to name of the current directory.
ifeq ($(project),)
PROJECT_NAME                            := $(notdir $(PWD))
else
PROJECT_NAME                            := $(project)
endif
export PROJECT_NAME

NODE_VERSION                            :=v16.19.1
export NODE_VERSION
NODE_ALIAS                              :=v16.0.0
export NODE_ALIAS
PACKAGE_MANAGER                         :=yarn
export PACKAGE_MANAGER
PACKAGE_INSTALL                         :=add
export PACKAGE_INSTALL


ifeq ($(force),true)
FORCE                                   := --force
endif
export FORCE

#GIT CONFIG
GIT_USER_NAME                           := $(shell git config user.name || echo)
export GIT_USER_NAME
GIT_USER_EMAIL                          := $(shell git config user.email || echo)
export GIT_USER_EMAIL
GIT_SERVER                              := https://github.com
export GIT_SERVER
GIT_PROFILE                             := $(shell git config user.name || echo)
export GIT_PROFILE
GIT_BRANCH                              := $(shell git rev-parse --abbrev-ref HEAD || echo)
export GIT_BRANCH
GIT_HASH                                := $(shell git rev-parse --short HEAD || echo)
export GIT_HASH
GIT_PREVIOUS_HASH                       := $(shell git rev-parse --short HEAD^1 || echo)
export GIT_PREVIOUS_HASH
GIT_REPO_ORIGIN                         := $(shell git remote get-url origin || echo)
export GIT_REPO_ORIGIN
GIT_REPO_NAME                           := $(PROJECT_NAME)
export GIT_REPO_NAME
GIT_REPO_PATH                           := $(HOME)/$(GIT_REPO_NAME)
export GIT_REPO_PATH

ifneq ($(bitcoin-datadir),)
BITCOIN_DATA_DIR                        := $(bitcoin-datadir)
else
BITCOIN_DATA_DIR                        := $(HOME)/.bitcoin
endif
export BITCOIN_DATA_DIR

ifeq ($(nocache),true)
NOCACHE                                 := --no-cache
#Force parallel build when --no-cache to speed up build
PARALLEL                                := --parallel
else
NOCACHE                                 :=
PARALLEL                                :=
endif
ifeq ($(parallel),true)
PARALLEL                                := --parallel
endif
ifeq ($(para),true)
PARALLEL                                := --parallel
endif
export NOCACHE
export PARALLEL

ifeq ($(verbose),true)
VERBOSE                                 := --verbose
else
VERBOSE                                 :=
endif
export VERBOSE

BREW                                    := $(shell which brew || echo)
export BREW
BREW_PREFIX                             := $(shell brew --prefix || echo)
export BREW_PREFIX
BREW_CELLAR                             := $(shell brew --cellar || echo)
export BREW_CELLAR
HOMEBREW_NO_ENV_HINTS                   := false
export HOMEBREW_NO_ENV_HINTS

#PORTER_VERSION                         :=v1.0.1
PORTER_VERSION                          :=latest
export PORTER_VERSION

.ONESHELL:
#.PHONY:-
.SILENT:

#.PHONY: $(TASKS)
#$(TASKS):
#	@yarn $@ $(call args,$@)

##make	:	command			description
##	:
-:## 	default - try 'make submodules'
-:
	#NOTE: 2 hashes are detected as 1st column output with color
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?##/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
submodules:#### 	git submodule update --init --recursive
	type -P git && git submodule update --init --recursive || echo "install git..."

####	:-               	default - try 'make submodules'
####	:submodules      	git submodule update --init --recursive
####	:init            	init
####	:help            	print verbose help
####	:report          	print make variables
####	:github          	install hub utility
####	:hub             	
####	:nvm             	nvm
####	:nvm-clean       	nvm-clean
####	:tag             	git tag and git push --force
####	:venv            	additional make venv commands
####	:venv-help       	venv-help
####	:venv-install    	create .venv
####	:venv-test       	add more python3.8 tests here

init:#### 	init
	echo 'export PATH="$(PWD):$(PATH)"' >> $(HOME)/.bash_profile
	echo $(NODE_VERSION) > .nvmrc

help:#### 	print verbose help
	@echo ''
	@echo '	[COMMAND]		[DESCRIPTION]'
	@echo ''
	@sed -n 's/^####//p' ${MAKEFILE_LIST} | sed -e 's/://'| sed -e 's/		//'
	@echo ""

report:#### 	print make variables
	@echo ''
	@echo 'CMAKE=${CMAKE}	'
	@echo ''
	@echo 'TIME=${TIME}	'
	@echo 'SHELL=${SHELL}	'
	@echo 'POWERSHELL=${POWERSHELL}	'
	@echo 'PROJECT_NAME=${PROJECT_NAME}	'
	@echo ''
	@echo 'DOCKER=${DOCKER}	'
	@echo 'DOCKER_COMPOSE=${DOCKER_COMPOSE}	'
	@echo ''
	@echo 'NODE_VERSION=${NODE_VERSION}	'
	@echo 'NODE_ALIAS=${NODE_ALIAS}	'
	@echo ''
	@echo 'GIT_USER_NAME=${GIT_USER_NAME}	'
	@echo 'GIT_USER_EMAIL=${GIT_USER_EMAIL}	'
	@echo 'GIT_SERVER=${GIT_SERVER}	'
	@echo 'GIT_PROFILE=${GIT_PROFILE}	'
	@echo 'GIT_BRANCH=${GIT_BRANCH}	'
	@echo 'GIT_HASH=${GIT_HASH}	'
	@echo 'GIT_PREVIOUS_HASH=${GIT_PREVIOUS_HASH}	'
	@echo 'GIT_REPO_ORIGIN=${GIT_REPO_ORIGIN}	'
	@echo 'GIT_REPO_NAME=${GIT_REPO_NAME}	'
	@echo 'GIT_REPO_PATH=${GIT_REPO_PATH}	'
	@echo ''
	@echo 'BREW=${BREW}	'
	@echo 'HOMEBREW_BREW_GIT_REMOTE=${HOMEBREW_BREW_GIT_REMOTE}	'
	@echo 'HOMEBREW_CORE_REMOTE=${HOMEBREW_CORE_GIT_REMOTE}	'
	@echo 'HOMEBREW_INSTALL_FROM_API=${HOMEBREW_INSTALL_FROM_API}	'
	@echo 'BREW_PREFIX=${BREW_PREFIX}	'
	@echo 'BREW_CELLAR=${BREW_CELLAR}	'
	@echo 'HOMEBREW_NO_ENV_HINTS=${HOMEBREW_NO_ENV_HINTS}	'
	@echo ''
	@echo 'PORT_VERSION=${PORTER_VERSION}	'

github:#### 	install hub utility
	$(PWD)/install-github-utility.sh
hub:#### 	
	$(PWD)/install-github-utility.sh

nvm:#### 	nvm
	@curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash || git pull -C $(HOME)/.nvm && export NVM_DIR="$(HOME)/.nvm" && [ -s "$(NVM_DIR)/nvm.sh" ] && \. "$(NVM_DIR)/nvm.sh" && [ -s "$(NVM_DIR)/bash_completion" ] && \. "$(NVM_DIR)/bash_completion"  && nvm install $(NODE_VERSION) && nvm use $(NODE_VERSION)
	@source ~/.bashrc && nvm alias $(NODE_ALIAS) $(NODE_VERSION)
nvm-clean: ## 	nvm-clean
	@rm -rf ~/.nvm

tag:#### 	git tag and git push --force
	@git tag $(OS)-$(OS_VERSION)-$(ARCH)-$(shell date +%s)
	@git push -f --tags

.PHONY: venv
venv:#### 	additional make venv commands
	$(MAKE) -f venv.mk

-include venv.mk
-include hub.mk
# vim: set noexpandtab:
# vim: set setfiletype make
