resource "aws_iam_policy" "policy" {
  name        = "WAPServicePermissionBoundary"
  path        = "/boundary/"
  description = "Boundary Policy for WAP services"

  policy = data.aws_iam_policy_document.permission_boundary_service.json
}

resource "aws_iam_policy" "policy_boundary_deploy" {
  name        = "WAPDeployPermissionBoundary"
  path        = "/boundary/"
  description = "Boundary Policy for WAP deploy roles"

  policy = data.aws_iam_policy_document.permission_boundary_service.json
}

data "aws_iam_policy_document" "permission_boundary_service" {
  statement {
    sid    = "AllowedServices"
    effect = "Allow"
    actions = [
      "apigateway:*",
      "cloudtrail:*",
      "dynamodb:*",
      "ec2:*",
      "kms:*",
      "lambda:*",
      "s3:*",
      "secertsmanager:*",
      "scheduler:*",
      "ssm:*",
    ]
    resources = [
      "*",
    ]
  }

  statement {
    sid    = "IAMReadOnly"
    effect = "Allow"
    actions = [
      "iam:Get*",
      "iam:List*",
      "sts:*",
    ]
    resources = [
      "*",
    ]
  }

  statement {
    sid    = "DenyModifyTerraformS3"
    effect = "Deny"
    actions = [
      "s3:*Object",
      "s3:Delete**",
      "s3:*BucketPolicy",
    ]
    resources = [
      "arn:aws:s3:::tf-${data.aws_caller_identity.current.account_id}",
      "arn:aws:s3:::tf-${data.aws_caller_identity.current.account_id}/*",
    ]

  }
}

data "aws_iam_policy_document" "permission_boundary_deploy" {
  statement {
    sid    = "AllowedServices"
    effect = "Allow"
    actions = [
      "apigateway:*",
      "cloudtrail:*",
      "dynamodb:*",
      "ec2:*",
      "kms:*",
      "lambda:*",
      "s3:*",
      "secertsmanager:*",
      "scheduler:*",
      "ssm:*",
    ]
    resources = [
      "*",
    ]
  }

  statement {
    sid    = "IAMReadOnly"
    effect = "Allow"
    actions = [
      "iam:Get*",
      "iam:List*",
      "sts:*",
    ]
    resources = [
      "*",
    ]
  }
}
