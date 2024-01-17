data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "iam_seed_role" {
  statement {
    sid = "IAMReadOnly"
    actions = [
      "iam:Get*",
      "iam:List*",
    ]
    resources = ["*"]
  }

  statement {
    sid = "IAMRolesWithBoundary"
    actions = [
      "iam:CreateRole",
      "iam:PutRolePermissionsBoundary",
      "iam:*RolePolicy",
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/wap/*",
    ]
    condition {
      test     = "StringLike"
      variable = "iam:PermissionsBoundary"
      values = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/boundary/*",
      ]
    }
  }

  statement {
    sid = "IAMRolesWithoutBoundary"
    actions = [
      "iam:DeleteRole",
      "iam:UpdateRole",
      "iam:UpdateRoleDescription",
      "iam:TagRole",
      "iam:UntagRole",
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/wap/*",
    ]
  }

  statement {
    sid = "IAMUsersWithBoundary"
    actions = [
      "iam:CreateUser",
      "iam:*UserPermissionsBoundary",
      "iam:*UserPolicy",
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/wap/*",
    ]
    condition {
      test     = "StringLike"
      variable = "iam:PermissionsBoundary"
      values = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/boundary/*",
      ]
    }
  }
  statement {
    sid = "IAMUsersWithoutBoundary"
    actions = [
      "iam:UpdateUser",
      "iam:TagUser",
      "iam:UntagUser",
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/wap/*",
    ]
  }

  statement {
    sid = "IAMPolicies"
    actions = [
      "iam:CreatePolicy",
      "iam:DeletePolicy",
      "iam:*PolicyVersion",
      "iam:TagPolicy",
      "iam:UntagPolicy",
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/wap/*",
    ]
  }

  statement {
    sid = "S3ListBucket"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::tf-${data.aws_caller_identity.current.account_id}",
    ]
  }

  statement {
    sid = "S3AccessTFBucket"
    actions = [
      "s3:CreateObject",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::tf-${data.aws_caller_identity.current.account_id}/wap-iam-*",
    ]
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = ["${aws_iam_openid_connect_provider.github_actions.arn}"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com",
      ]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = flatten([
        "repo:wmax641/wap-iam-accounts:environment:production",
        data.aws_caller_identity.current.account_id == var.account_id_dev ? ["repo:wmax641/wap-iam-accounts:environment:development"] : [],
      ])
    }
  }
}
