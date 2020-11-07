SOCKS Proxy Server on Linode
===

[![Build Status](https://cloud.drone.io/api/badges/jmarhee/terraform-linode-proxy/status.svg)](https://cloud.drone.io/jmarhee/terraform-linode-proxy)

Deploys a `nanode` instance on [Linode](linode.com) via Terraform for use as an SSH tunnel SOCKS v5 proxy server.

Setup
---

Get your [Linode API token](https://cloud.linode.com/profile/tokens), and set `linode_token` to this value in `terraform.tfvars` or on first-run.

Run:

```bash
terraform init
```

then:

```bash
terraform plan
terraform apply -auto-approve
```
to deploy the proxy host, and setup the tunnel. You can, then, set the proxy address in your browser.

Usage
---

Specify a `browser_command`, if you wish to launch your browser using the proxy on completion:

```bash
browser_command = "open -a '/Applications/Google Chrome.app' --args --incognito"
set_osx_proxy   = true
```

if you are on OS X, you can use the `set_osx_proxy` option above to enable the proxy before launching the browser as well. Otherwise, `all_proxy` is set when the `browser_command` is run (which sets the proxy on most Linux systems).

Verifying
---

To test this manually, in your browser, use the address `http://127.0.0.1:8888` to direct client traffic through your proxy host.

You can [find directions for common web browsers here](https://hide-ip-proxy.com/google-chrome-firefox-socks-proxy-how-to-use/) for configuring a SOCKS proxy.

You can test this yourself (which is also the last step in the module, which you'll see in the Terraform output) by running:

```bash
curl -s --socks5-hostname http://127.0.0.1:8888 -L http://ipinfo.io/json
```

to confirm your HTTP traffic is going through the proxy host.

Troubleshooting
---

The output will include your host address:

```
Outputs:

Tunnel_Host = Set SOCKSv5 host to:
        127.0.0.1:8888
in order to proxy through xx.xx.xx.xx
```

This latter address will be your host address on Linode, which you can check to confirm is online and troubleshoot connectivity further. 

If, on OS X,  the node launches properly and there is an `ssh` process active, but you have not been connected to the proxy, run:

```bash
USER=root HOST=${output_host_ip} scripts/proxy_status.sh
```

If you are on OS X, and after `destroy`, you are receiving an error indicating the proxy is no longer available, you may need to manually deconfigure the proxy configuration by running:

```bash
networksetup -setsocksfirewallproxystate wi-fi off
```

on your local machine. 
