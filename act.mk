act-help:##### 	act-help
	@awk 'BEGIN {FS = ":.*?##### 	"} /^[a-zA-Z_-]+:.*?##### 	/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
act-install:##### 	create .act
	@GITHUB_TOKEN=$(cat ~/GH_ACT_TOKEN.txt) act -vbr
# vim: set noexpandtab:
# vim: set setfiletype make
