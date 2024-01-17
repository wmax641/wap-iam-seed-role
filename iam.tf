resource "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]
  thumbprint_list = var.thumbprint_list_github

  tags = var.common_tags
}

resource "aws_iam_role" "iam_seed_role" {
  name        = "IAMSeedRole"
  description = "Assumed by Github Actions to deploy other IAM resources"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = merge({ "Name" = "IAMSeedRole" }, var.common_tags)
}

resource "aws_iam_policy" "iam_seed_role" {
  name        = "IAMSeedRolePermissionPolicy"
  path        = "/"
  description = "Basic Permissions for IAMSeedRole"

  policy = data.aws_iam_policy_document.iam_seed_role.json

  tags = merge({ "Name" = "IAMSeedRolePolicy" }, var.common_tags)
}

resource "aws_iam_policy_attachment" "iam_seed_role" {
  name       = "IAMSeedRole Policy Attachment"
  roles      = [aws_iam_role.iam_seed_role.name]
  policy_arn = aws_iam_policy.iam_seed_role.arn
}
