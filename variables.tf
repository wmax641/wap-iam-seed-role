variable "base_name" {
  description = "Common prefix used for naming resources of this project"
  default     = "wap-iam-seed-role"
}
variable "common_tags" {
  description = "Common tags used in resources of this project"
  default = {
    "project" = "wmax641/wap-iam-seed-role"
  }
}
variable "thumbprint_list_github" {
  description = "A list of thumbprints to trust. This may change from time to time"
  type        = list(string)
  default     = ["1b511abead59c6ce207077c0bf0e0043b1382612"]
}
