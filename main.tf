provider "aws" {
  region = "us-west-1"
}

resource "aws_iam_policy" "route53_policy" {
  name        = "route53_policy"
  path        = "/"
  description = "Cert-manager Route53 Policy"

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






# resource "aws_iam_access_key" "route53" {
#   user    = aws_iam_user.route53.name
#   pgp_key = "keybase:some_person_that_exists"
# }

# resource "aws_iam_user" "route53" {
#   name = "route53"
#   path = "."
# }

# resource "aws_iam_user_policy" "route53_role" {
#   name = "test"
#   user = aws_iam_user.route53.name

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": "route53:GetChange",
#       "Resource": "arn:aws:route53:::change/*"
#     },
#     {
#       "Effect": "Allow",
#       "Action": [
#         "route53:ChangeResourceRecordSets",
#         "route53:ListResourceRecordSets"
#       ],
#       "Resource": "arn:aws:route53:::hostedzone/*"
#     },
#     {
#       "Effect": "Allow",
#       "Action": "route53:ListHostedZonesByName",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

# output "secret" {
#   value = aws_iam_access_key.route53.encrypted_secret
# }
