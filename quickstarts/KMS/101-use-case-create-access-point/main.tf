variable "region" {
  default = "cn-shanghai"
}

provider "alicloud" {
  region = var.region
}

# 创建网络控制规则
resource "alicloud_kms_network_rule" "network_rule_example"{
# 网络规则的名称
network_rule_name    = "sample_network_rule"
# 描述
description          = "description_test_module"
# 允许的源私有IP地址范围
source_private_ip             = ["172.16.0.0/12"]
}

# 创建访问控制策略
resource "alicloud_kms_policy" "policy_example"{
# 策略名称
policy_name    = "sample_policy"
# 描述
description    = "description_test_module"
# 定义的权限列表，包括加密服务密钥和加密服务密钥的访问权限
permissions    = ["RbacPermission/Template/CryptoServiceKeyUser","RbacPermission/Template/CryptoServiceSecretUser"]
# 资源列表，指向所有密钥和凭据
resources    = ["key/*","secret/*"]
# KMS实例的ID，替换为您的KMS实例ID
kms_instance_id    = "kst-shh6715bc67can2kalkwo"
# 访问控制规则，以JSON格式提供，引用先前定义的网络规则
access_control_rules = <<EOF
  {
      "NetworkRules":[
          "alicloud_kms_network_rule.network_rule_example.network_rule_name"
      ]
  }
  EOF
}

# 创建应用接入点的资源定义
resource "alicloud_kms_application_access_point" "application_access_point_example"{
# 应用接入点的名称
application_access_point_name    = "sample_aap"
# 关联的策略列表，引用之前创建的访问控制策略名称
policies    = [alicloud_kms_policy.policy_example.policy_name]  
# 应用接入点的描述
description    = "aap_description"
}

# 创建应用身份凭证的资源定义
resource "alicloud_kms_client_key" "client_key"{
# 指定应用接入点的名称
aap_name    = alicloud_kms_application_access_point.application_access_point_example.application_access_point_name
# 身份凭证的密码,替换为您的密码
password    = "P@ssw0rd123"
# 身份凭证的有效开始时间
not_before      = "2023-09-01T14:11:22Z"
not_after       = "2032-09-01T14:11:22Z"
# 设置保存应用身份凭证的本地文件地址
private_key_data_file = "./client_key.json"

}