variable "linode_token" {}
variable "ssh_user" {
  default = "root"
}
variable "ssh_key" {
  default = "~/.ssh/id_rsa.pub"
}
variable "open_browser" {
  default     = true
  description = "Open Chrome (OS X Only) with Proxy set"
}
variable "browser_command" {
  default     = "null"
  description = "i.e. 'open -a /Applications/Google Chrome.app' --args --incognito http://ipinfo.io/json' for OSX or `chrome.exe` for Windows"
}
variable "set_osx_proxy" {
  default     = false
  description = "Sets OS X SOCKS Proxy (all_proxy is set for other OS that use this variable to specify a proxy when you enable open_browser)"
}
