resource "null_resource" "tunnel_connection" {
  depends_on = [linode_instance.tunnel]
  provisioner "local-exec" {
    command = "chmod +x scripts/connect.sh; ./scripts/connect.sh"
    environment = {
      HOST = linode_instance.tunnel.ip_address
      USER = var.ssh_user
    }
  }
}

resource "null_resource" "test_tunnel" {
  depends_on = [null_resource.tunnel_connection]
  provisioner "local-exec" {
    command = "sleep 10; curl -s --socks5-hostname http://127.0.0.1:8888 -L http://ipinfo.io/json"
  }
}
