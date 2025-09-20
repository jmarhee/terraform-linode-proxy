.SILENT:
tag-release:
	if [[ $(TAG) == v?.?.? ]]; then echo "Tagging $(TAG)"; elif [[ $(TAG) == v?.?.?? ]]; then echo "Tagging $(TAG)"; else echo "Bad Tag Format: $(TAG)"; exit 1; fi && git tag -a $(TAG) -m "Releasing $(TAG)" ; read -p "Push tag: $(TAG)? " push_tag ; if [ "${push_tag}"="yes" ]; then git push origin $(TAG); fi

.SILENT:
create-release:
	if [[ $(TAG) == v?.?.? ]]; then echo "Cutting release from $(TAG)"; elif [[ $(TAG) == v?.?.?? ]]; then echo "Cutting release from $(TAG)"; else echo "Bad Tag Format, cannot cut release: $(TAG)"; exit 1; fi && git tag -a $(TAG) -m "Releasing $(TAG)" ; read -p "Cut release from tag: $(TAG)? " push_tag ; if [ "${push_tag}"="yes" ]; then TAG=$(TAG) ./make-release.sh; fi

proxy-up:
	terraform apply -auto-approve

proxy-down:
	terraform destroy -auto-approve

proxy-status:
	if [ "$(curl -s ipinfo.io/json | jq .ip)" = "$(terraform state show linode_instance.tunnel | grep ip_address | awk '{print $3}')" ]; then echo "Connected."; else echo "Tunnel not setup, or no Terraform state detected. (Check 'terraform state list' to see if Linode is created, or check IP at https://ipinfo.io/json)"; fi

proxy-test:
	curl -s --socks5-hostname http://127.0.0.1:8888 -L http://ipinfo.io/json

mac-proxy-down:
	networksetup -setsocksfirewallproxystate wi-fi off

mac-proxy-reconnect:
	# If you have not destroyed the proxy server, and wish to simply reconnect.
	if [[ "$(terraform state show linode_instance.tunnel | grep ip_address | awk '{print $3}')" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then terraform apply -target=null_resource.set_osx_proxy -auto-approve; else echo "No Linode configured. Run 'make proxy-up' to connect."; fi
