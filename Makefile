.SILENT:
tag-release:
	if [[ $(TAG) == v?.?.? ]]; then echo "Tagging $(TAG)"; elif [[ $(TAG) == v?.?.?? ]]; then echo "Tagging $(TAG)"; else echo "Bad Tag Format: $(TAG)"; exit 1; fi && git tag -a $(TAG) -m "Releasing $(TAG)" ; read -p "Push tag: $(TAG)? " push_tag ; if [ "${push_tag}"="yes" ]; then git push self $(TAG); fi

proxy-up:
	terraform apply -auto-approve

proxy-down: 
	terraform destroy -auto-approve

proxy-test:
	curl http://ipinfo.io/json

mac-proxy-down:
	networksetup -setsocksfirewallproxystate wi-fi off

