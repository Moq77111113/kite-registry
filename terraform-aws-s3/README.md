# AWS S3 Bucket Template

Production-ready S3 bucket configuration with security best practices.

## Features

- ✅ Versioning support
- ✅ Server-side encryption (AES256)
- ✅ Public access blocking
- ✅ Optional lifecycle policies
- ✅ Customizable tags

## Usage

```hcl
module "my_bucket" {
  source = "./terraform-aws-s3"

  bucket_name         = "my-app-data-bucket"
  environment         = "production"
  versioning_enabled  = true
  enable_lifecycle    = true

  tags = {
    Project = "MyApp"
    Owner   = "DevOps Team"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| bucket_name | Name of the S3 bucket | string | - | yes |
| environment | Environment name | string | "dev" | no |
| versioning_enabled | Enable versioning | bool | true | no |
| enable_lifecycle | Enable lifecycle rules | bool | false | no |
| tags | Additional tags | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The name of the bucket |
| bucket_arn | The ARN of the bucket |
| bucket_domain_name | The bucket domain name |
| bucket_regional_domain_name | The bucket region-specific domain name |

## Security

- Public access is blocked by default
- Encryption at rest using AES256
- Versioning enabled for data protection
