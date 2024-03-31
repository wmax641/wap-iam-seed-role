variable "base_name" {
  description = "Common prefix used for naming resources of this project"
  default     = "wap-iam-seed-role"
}
variable "common_tags" {
  description = "Common tags used in resources of this project"
  default = {
    "repo" = "wmax641/wap-iam-seed-role"
  }
}

variable "allowed_services" {
  type        = list(string)
  description = "List of services to allow in boundary"
  default = [
    "acm:*",
    "apigateway:*",
    "cloudtrail:*",
    "dynamodb:*",
    "ec2:*",
    "ecr:*",
    "events:*",
    "kms:*",
    "lambda:*",
    "route53:*",
    "s3:*",
    "scheduler:*",
    "secretsmanager:*",
    "ssm:*",
  ]
}

variable "thumbprint_list_github" {
  description = "A list of thumbprints to trust. This may change from time to time"
  type        = list(string)
  default     = ["1b511abead59c6ce207077c0bf0e0043b1382612"]
}

variable "account_id_prd" {
  type    = string
  default = "640722323464"
}
variable "account_id_dev" {
  type    = string
  default = "071440211637"
}

