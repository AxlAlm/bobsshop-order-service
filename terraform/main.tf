

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  alias   = "stockholm"
  region  = "eu-north-1"
}

data "aws_caller_identity" "current" {}


resource "aws_iam_user" "user" {
  name = "erc-${var.repository_name}-user"
}

# resource "aws_iam_access_key" "lb" {
#   user = aws_iam_user.user.name
# }

resource "aws_iam_user_policy" "user_policy" {
  name   = "assume-erc-exc-role"
  user   = aws_iam_user.user.name
  policy = jsonencode({
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Condition": {
                        "StringEquals": {
                            "aws:ResourceTag/Role": "ecr-exc-role"
                        }
                    },
                    "Action": [
                        "sts:AssumeRole"
                    ],
                    "Resource": "*",
                    "Effect": "Allow"
                }
            ]
        }
    )
}

resource "aws_iam_role" "role" {
  name = "erc-${var.repository_name}-exc-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${aws_iam_user.user.name}"
        }
      },
    ]
  })
  tags = {
    Role = "ecr-exc-role"
  }
}

resource "aws_iam_role_policy" "policy" {
  name = "erc-${var.repository_name}-exc"
  role = aws_iam_role.role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:*",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:ecr:*:${data.aws_caller_identity.current.account_id}:repository/${var.repository_name}"
      },
    ]
  })
}


resource "aws_ecr_repository" "repo" {
  name                 = "${var.repository_name}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
