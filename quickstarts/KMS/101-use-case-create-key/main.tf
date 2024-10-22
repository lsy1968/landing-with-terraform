variable "region" {
  default = "cn-shanghai"
}

provider "alicloud" {
  region = var.region
}
# 创建默认密钥（主密钥）
resource "alicloud_kms_key" "default_key_encrypt_decrypt" {
  description = "default_key_encrypt_decrypt description"
  # 密钥的使用方式。默认值：ENCRYPT/DECRYPT。有效值：ENCRYPT/DECRYPT: 加密或解密数据。
  key_usage = "ENCRYPT/DECRYPT"
  # 密钥的规格。默认值：Aliyun_AES_256。
  key_spec = "Aliyun_AES_256"
  # 密钥材料的来源。默认值：Aliyun_KMS。有效值：Aliyun_KMS, EXTERNAL。
  origin = "Aliyun_KMS"
  # 周期
  pending_window_in_days = 7
  # 要分配给资源的标签映射。可选参数
  tags = {
      "Environment" = "Production"
      "Name" = "KMS-01"
      "SupportTeam" = "PlatformEngineering"
      "Contact" = "gro**@test.com"
    }
}
# 密钥别名为alias/default_key_encrypt_decrypt_alias，在整个阿里云账号下唯一。
resource "alicloud_kms_alias" "default_key_encrypt_decrypt_alias" {
  # CMK 的别名
  alias_name = "alias/kms"
  # 密钥id
  key_id = alicloud_kms_key.default_key_encrypt_decrypt.id
}