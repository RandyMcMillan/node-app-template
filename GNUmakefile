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
-:## - default - try 'make submodules'
-:
	#NOTE: 2 hashes are detected as 1st column output with color
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?##/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
submodules:#### 	git submodule update --init --recursive
	type -P git && git submodule update --init --recursive || echo "install git..."
nodegit$(EXEEXT):#### 	cd node_modules && node_gyp build
	-cd $(NODE_MODULE_DIR) && $(NODE_GYP) build
clean-local:#### 	cd node_modules && node-gyp clean
	-cd $(NODE_MODULE_DIR) && node-gyp clean


####	:	-
####	:	help
####	:	report			environment args
####	:
####	:	all			execute installer scripts
####	:	init
####	:	brew
####	:	keymap

####	:
####	:	whatami			report system info
####	:
####	:	adduser-git		add a user named git

keymap:#### 	install ./init/com.local.KeyRemapping.plist
	@mkdir -p ~/Library/LaunchAgents/
	@cat ./init/com.local.KeyRemapping.plist > ~/Library/LaunchAgents/com.local.KeyRemapping.plist
#REF: https://tldp.org/LDP/abs/html/abs-guide.html#IO-REDIRECTION
	#test hidutil && hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}' > /dev/null 2>&1 && echo "<Caps> = <Esc>" || echo wuh

init:#### 	init
	#@type -P chsh && chsh -s /bin/bash #&& ./scripts/initialize
	#["$(shell $(SHELL))" == "/bin/zsh"] && zsh --emulate sh
	#["$(shell $(SHELL))" == "/bin/zsh"] && chsh -s /bin/bash
	#@echo ...$(DOTFILES_PATH)
	#@[[ " ${PATH//:/ } " =~ "$(DOTFILES_PATH)" ]] && echo Found it || echo Not found
	cat $(PWD)/.bash_profile.in > $(PWD)/.bash_profile
	echo 'export PATH="$(DOTFILES_PATH):$(PATH)"' >> $(PWD)/.bash_profile
	echo $(NODE_VERSION) > .nvmrc
	#@./scripts/initialize
brew:#### 	install or update/upgrade brew
	export HOMEBREW_INSTALL_FROM_API=1
	@eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)" && brew upgrade  --casks && brew update
	type -P brew && echo -e "try\nbrew update --casks --greedy"|| ./install-brew.sh
	type -P brew && brew commands
brew-bundle-dump:## create Brewfile
	@eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)" && brew bundle dump -f
iterm:## brew install --cask iterm2
	rm -rf /Applications/iTerm.app
	test brew && brew install -f --cask iterm2 && \
		curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash

.PHONY: help
help:#### 	print verbose help
	@echo '[COMMAND]		[DESCRIPTION] [EXTRA_ARGUMENTS]	'
	@echo '         		[EXTRA_ARGUMENTS]	'
	@echo ''
	@sed -n 's/^####//p' ${MAKEFILE_LIST} | sed -e 's/://'| sed -e 's/		//'
	@echo ""
	@echo "Useful Commands:"
	@echo ""
	@echo "git-\<TAB>";
	@echo "gpg-\<TAB>";
	@echo "bitcoin-\<TAB>";
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

#.PHONY:
#phony:
#	@sed -n 's/^.PHONY//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

whatami:#### 	bash ./whatami.sh
	@bash ./whatami.sh
#.PHONY:readme
#readme:
#	make help > source/COMMANDS.md
#	git add -f README.md && git commit -m "make readme" && git push -f origin master
.PHONY: adduser-git
##	:	adduser-git		add a user named git
adduser-git:#### 	source adduser-git.sh && adduser-git
	source $(PWD)/adduser-git.sh && adduser-git


##	:	bootstrap		source bootstrap.sh
.PHONY: bootstrap
bootstrap:#### 	./bootstrap.sh && make vim
	@bash -c "$(PWD)/bootstrap.sh" #force"
	@make vim


.PHONY: install
##	:	install		 	install sequence
install: executable
	@echo "install sequence here..."


.PHONY: github
github: executable#### 	config-github
	@./config-github

.ONESHELL:
nvm:#### 	nvm
	@curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash || git pull -C $(HOME)/.nvm && export NVM_DIR="$(HOME)/.nvm" && [ -s "$(NVM_DIR)/nvm.sh" ] && \. "$(NVM_DIR)/nvm.sh" && [ -s "$(NVM_DIR)/bash_completion" ] && \. "$(NVM_DIR)/bash_completion"  && nvm install $(NODE_VERSION) && nvm use $(NODE_VERSION)
	@source ~/.bashrc && nvm alias $(NODE_ALIAS) $(NODE_VERSION)
nvm-clean: ## 	nvm-clean
	@rm -rf ~/.nvm

####	:	all			
all: executable gnupg brew-libs
brew-libs: libassuan libgcrypt libgpg-error libksba libusb
node:
	bash -c "source $(PWD)/template && checkbrew install                       node"
node@18:
	bash -c "source $(PWD)/template && checkbrew install                       node@18"
node@16:
	bash -c "source $(PWD)/template && checkbrew install                       node@16"
node@14:
	bash -c "source $(PWD)/template && checkbrew install                       node@14"
node@12:
	bash -c "source $(PWD)/template && checkbrew install                       node@12"
node@10:
	bash -c "source $(PWD)/template && checkbrew install                       node@10"
yarn:
	bash -c "source $(PWD)/template && checkbrew install                       yarn"

.PHONY: shell alpine alpine-shell debian debian-shell d-shell
shell: alpine-shell
##	:	alpine-shell		run install-shell.sh alpine user=root
alpine-shell: alpine
alpine:
	test docker && ./install-shell.sh alpine || echo "make docker OR checkbrew -i docker"
##	:	alpine-build		run install-shell.sh alpine-build user=root
alpine-build:
	test docker && ./install-shell.sh alpine-build || echo "make docker OR checkbrew -i docker"
d-shell: debian-shell
##	:	debian-shell		run install-shell.sh debian user=root
debian-shell: debian
debian:
	test docker && ./install-shell.sh debian || echo "make docker OR checkbrew -i docker"
	./install-shell.sh debian

.PHONY: hub
hub: executable## 	install github utility
	$(DOTFILES_PATH)/./install-github-utility.sh

tag:
	@git tag $(OS)-$(OS_VERSION)-$(ARCH)-$(shell date +%s)
	@git push -f --tags

.ONESHELL:
touch-time:
	touch TIME
	echo $(TIME) $(shell git rev-parse HEAD) >> TIME

ifeq ($(bitcoin-version),)
	@echo Example:
	@echo add tag v22.0rc3
BITCOIN_VERSION:=v22.0rc3
else
BITCOIN_VERSION:=$(bitcoin-version)
endif
export BITCOIN_VERSION
.PHONY: bitcoin-test-battery
bitcoin-test-battery:
	bash -c "./bitcoin-test-battery.sh $(BITCOIN_VERSION) "

.PHONY: funcs
funcs:#### 	additional commands
	$(MAKE) -f funcs.mk
.PHONY: legit
legit:#### 	additional make legit
	$(MAKE) -f legit.mk
.PHONY: rust
rust:#### 	additional make rustcommands
	$(MAKE) -f rust.mk
.PHONY: venv
venv:#### 	additional make venv commands
	$(MAKE) -f venv.mk

-include venv.mk
# vim: set noexpandtab:
# vim: set setfiletype make
