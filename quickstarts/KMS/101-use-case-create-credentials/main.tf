variable "region" {
  default = "cn-shanghai"
}

provider "alicloud" {
  region = var.region
}

#您需要已创建KMS实例kst-shh6715bc67can2kalkwo，替换为您的KMS实例id
variable "soft_kms_instance" {
  default  = "kst-shh6715bc67can2kalkwo"
}
#您需要再KMS实例中创建一个密钥key-shh6715c21812y8i7zhki，替换为您的密钥id
variable "soft_kms_key" {
  default  = "key-shh6715c21812y8i7zhki"
}
# 创建通用凭据，凭据名称为kms_secret_general1，凭据值为secret_data_kms_secret_general1
resource "alicloud_kms_secret" "kms_secret_general" {
  # 名称
  secret_name = "kms_secret_general1"
  # 描述
  description = "secret_data_kms_secret_general"
  # 类型
  secret_type = "Generic"
  # 指定是否立即删除。默认值：false。有效值：true，false。
  force_delete_without_recovery = false
  # KMS 实例的 ID。
  dkms_instance_id = var.soft_kms_instance
  # KMS 密钥的 ID
  encryption_key_id = var.soft_kms_key
  # 版本号
  version_id = "v1"
  # 值的类型。默认值：text。有效值：text，binary。
  secret_data_type ="text"
  # 数据
  secret_data = "secret_data_kms_secret_general1"
}  