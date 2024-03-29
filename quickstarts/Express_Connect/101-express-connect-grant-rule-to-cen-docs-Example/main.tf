provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "tf-example"
}
data "alicloud_express_connect_physical_connections" "example" {
  name_regex = "^preserved-NODELETING"
}
resource "random_integer" "vlan_id" {
  max = 2999
  min = 1
}
resource "alicloud_express_connect_virtual_border_router" "example" {
  local_gateway_ip           = "10.0.0.1"
  peer_gateway_ip            = "10.0.0.2"
  peering_subnet_mask        = "255.255.255.252"
  physical_connection_id     = data.alicloud_express_connect_physical_connections.example.connections.0.id
  virtual_border_router_name = var.name
  vlan_id                    = random_integer.vlan_id.id
  min_rx_interval            = 1000
  min_tx_interval            = 1000
  detect_multiplier          = 10
}

resource "alicloud_cen_instance" "example" {
  cen_instance_name = var.name
}
data "alicloud_account" "default" {}

resource "alicloud_express_connect_grant_rule_to_cen" "example" {
  cen_id       = alicloud_cen_instance.example.id
  cen_owner_id = data.alicloud_account.default.id
  instance_id  = alicloud_express_connect_virtual_border_router.example.id
}