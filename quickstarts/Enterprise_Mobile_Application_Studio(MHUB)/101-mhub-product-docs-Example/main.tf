provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_mhub_product" "example" {
  product_name = "example_value"
}