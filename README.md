SOCKS Proxy Server on Linode
===

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

In your browser, use the address `http://127.0.0.1:8888` to direct client traffic through your proxy host.

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
