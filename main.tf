provider "aws" {
  region = "us-west-1"
}

resource "aws_iam_user" "cert_manager_route53_iam_user" {
  name = "cert_manager_route53_iam_user"
}

resource "aws_iam_access_key" "cert_manager_route53_access_key" {
  user = aws_iam_user.cert_manager_route53_iam_user.name
}

resource "aws_iam_user_policy" "cert_manager_route53_user_policy" {
  name = "cert_manager_route53_user_policy"
  user = aws_iam_user.cert_manager_route53_iam_user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "route53:GetChange",
      "Resource": "arn:aws:route53:::change/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets",
        "route53:ListResourceRecordSets"
      ],
      "Resource": "arn:aws:route53:::hostedzone/*"
    },
    {
      "Effect": "Allow",
      "Action": "route53:ListHostedZonesByName",
      "Resource": "*"
    }
  ]
}
EOF
}

output "access_key" {
  value = aws_iam_access_key.cert_manager_route53_access_key.id
}

output "secret_key" {
  value = aws_iam_access_key.cert_manager_route53_access_key.secret
  sensitive = true
}
