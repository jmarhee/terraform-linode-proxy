output "Tunnel_Host" {
  value = "Set SOCKSv5 host to:\n\t127.0.0.1:8888\nin order to proxy through ${linode_instance.tunnel.ip_address}"
}