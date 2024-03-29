variable "name" {
  default = "example_value"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_pvtz_resolver_zones" "default" {
  status = "NORMAL"
}
data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_vpc" "default" {
  count      = 3
  vpc_name   = var.name
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default" {
  count      = 2
  vpc_id     = alicloud_vpc.default[2].id
  cidr_block = cidrsubnet(alicloud_vpc.default[2].cidr_block, 8, count.index)
  zone_id    = data.alicloud_pvtz_resolver_zones.default.zones[count.index].zone_id
}

resource "alicloud_security_group" "default" {
  vpc_id = alicloud_vpc.default[2].id
  name   = var.name
}

resource "alicloud_pvtz_endpoint" "default" {
  endpoint_name     = "${var.name}-${random_integer.default.result}"
  security_group_id = alicloud_security_group.default.id
  vpc_id            = alicloud_vpc.default[2].id
  vpc_region_id     = data.alicloud_regions.default.regions.0.id
  ip_configs {
    zone_id    = alicloud_vswitch.default[0].zone_id
    cidr_block = alicloud_vswitch.default[0].cidr_block
    vswitch_id = alicloud_vswitch.default[0].id
  }
  ip_configs {
    zone_id    = alicloud_vswitch.default[1].zone_id
    cidr_block = alicloud_vswitch.default[1].cidr_block
    vswitch_id = alicloud_vswitch.default[1].id
  }

}

resource "alicloud_pvtz_rule" "default" {
  endpoint_id = alicloud_pvtz_endpoint.default.id
  rule_name   = "${var.name}-${random_integer.default.result}"
  type        = "OUTBOUND"
  zone_name   = var.name
  forward_ips {
    ip   = "114.114.114.114"
    port = 8080
  }
}

resource "alicloud_pvtz_rule_attachment" "default" {
  rule_id = alicloud_pvtz_rule.default.id
  vpcs {
    region_id = data.alicloud_regions.default.regions.0.id
    vpc_id    = alicloud_vpc.default[0].id
  }
  vpcs {
    region_id = data.alicloud_regions.default.regions.0.id
    vpc_id    = alicloud_vpc.default[1].id
  }
}