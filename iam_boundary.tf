resource "aws_iam_policy" "policy" {
  name        = "WAPServicePermissionBoundary"
  path        = "/boundary/"
  description = "Boundary Policy for WAP services"

  policy = data.aws_iam_policy_document.permission_boundary_service.json

  tags = var.common_tags
}

resource "aws_iam_policy" "policy_boundary_deploy" {
  name        = "WAPDeployPermissionBoundary"
  path        = "/boundary/"
  description = "Boundary Policy for WAP deploy roles"

  policy = data.aws_iam_policy_document.permission_boundary_deploy.json

  tags = var.common_tags
}

