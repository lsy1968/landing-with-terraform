<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_kms_secret.kms_secret_general](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shanghai"` | no |
| <a name="input_soft_kms_instance"></a> [soft\_kms\_instance](#input\_soft\_kms\_instance) | 您需要已创建KMS实例kst-shh6715bc67can2kalkwo，替换为您的KMS实例id | `string` | `"kst-shh6715bc67can2kalkwo"` | no |
| <a name="input_soft_kms_key"></a> [soft\_kms\_key](#input\_soft\_kms\_key) | 您需要再KMS实例中创建一个密钥key-shh6715c21812y8i7zhki，替换为您的密钥id | `string` | `"key-shh6715c21812y8i7zhki"` | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create credentials](http://help.aliyun.com/document_detail/2572881.htm) 

<!-- docs-link --> 