venv-help:##### 	venv-help
	@awk 'BEGIN {FS = ":.*?##### 	"} /^[a-zA-Z_-]+:.*?##### 	/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
venv-install:##### 	create .venv
	@touch requirements.txt
	test -d .venv || $(shell which python3) -m virtualenv .venv
	( \
	   source .venv/bin/activate; pip3 install -r requirements.txt; \
	);
	@echo "To activate (venv)"
	@echo "try:"
	@echo ". .venv/bin/activate"
	@echo "or:"
	@echo "make venv-test"
venv-test:##### 	add more python3 tests here
	# insert test commands here
	@touch requirements.txt
	test -d .venv || $(shell which python3) -m virtualenv .venv
	( \
	   source .venv/bin/activate; pip3 install -r requirements.txt; \
	);
# vim: set noexpandtab:
# vim: set setfiletype make
