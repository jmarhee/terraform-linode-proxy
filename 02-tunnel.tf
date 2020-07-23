resource "random_string" "tunnel_label" {
  length      = 6
  special     = false
  upper       = false
  min_lower   = 6
  min_numeric = 6
}

resource "linode_instance" "tunnel" {
  region          = "us-central"
  type            = "g6-nanode-1"
  label           = "tunnel-${random_string.tunnel_label.result}"
  image           = "linode/ubuntu18.04"
  authorized_keys = ["${chomp(file(var.ssh_key))}"]
}
