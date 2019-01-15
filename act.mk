act-help:###### 	act-help
	@awk 'BEGIN {FS = ":.*?###### 	"} /^[a-zA-Z_-]+:.*?###### 	/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
main:###### 	main.yml
	@GITHUB_TOKEN=$(cat ~/GH_ACT_TOKEN.txt) act -vbr -W .github/workflows/main.yml
# vim: set noexpandtab:
# vim: set setfiletype make
