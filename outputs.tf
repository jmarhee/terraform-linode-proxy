output "Tunnel_Host" {
  value = "Set SOCKSv5 host to:\n\t127.0.0.1:8888\nin order to proxy through ${linode_instance.tunnel.ip_address}"
}

output "Browser_Info" {
  value = "If you ran this plan with `open_browser` set `true`, then it will open to http://ipinfo.io/json; confirm you are connected through your proxy on this page before proceeding."
}
