resource "linode_instance" "tunnel" {
  region          = "us-central"
  type            = "g6-nanode-1"
  label           = "tunnel"
  image           = "linode/ubuntu18.04"
  authorized_keys = ["${chomp(file(var.ssh_key))}"]
}
