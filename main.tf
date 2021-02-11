provider "linode" {
  token = var.linode_token
}

resource "random_string" "tunnel_label" {
  length      = 6
  special     = false
  upper       = false
  min_lower   = 3
  min_numeric = 3
}

resource "linode_instance" "tunnel" {
  region          = var.region
  type            = "g6-nanode-1"
  label           = "tunnel-${random_string.tunnel_label.result}"
  image           = "linode/ubuntu18.04"
  authorized_keys = ["${chomp(file(var.ssh_key))}"]
}

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
    environment = {
      all_proxy = "socks://127.0.0.1:8888/"
    }
    command = "sleep 10; curl -s --socks5-hostname $all_proxy -L http://ipinfo.io/json"
  }
}

resource "null_resource" "set_osx_proxy" {
  depends_on = [null_resource.test_tunnel]
  count      = var.set_osx_proxy == true ? 1 : 0
  provisioner "local-exec" {
    command = "chmod +x scripts/proxy_status.sh; ./scripts/proxy_status.sh"
    environment = {
      HOST = linode_instance.tunnel.ip_address
      USER = var.ssh_user
    }
  }
  provisioner "local-exec" {
    when    = destroy
    command = "networksetup -setsocksfirewallproxystate wi-fi off; rm nohup.out"
  }
}

resource "null_resource" "open_browser" {
  depends_on = [null_resource.test_tunnel]
  count      = var.open_browser == true ? 1 : 0
  provisioner "local-exec" {
    environment = {
      all_proxy = "socks://127.0.0.1:8888/"
    }
    command = var.browser_command
  }
}
