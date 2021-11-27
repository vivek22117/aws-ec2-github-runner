#################################################
#       EKS Cluster IAM Role                    #
#################################################
resource "aws_iam_role" "github_runner_iam_role" {
  name               = "${var.github_runner_name}-cluster-${var.environment}-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}



resource "aws_iam_policy" "github_runner_iam_policy" {
  name        = "GitHubRunnerPolicy"
  description = "required to create start EC2 instance and attached IAM role"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "ec2:RunInstances",
              "ec2:TerminateInstances",
              "ec2:DescribeInstances"
              "ec2:DescribeInstanceStatus"
              "ec2:ReplaceIamInstanceProfileAssociation"
              "ec2:AssociateIamInstanceProfile"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
              "iam:PassRole"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
              "ec2:CreateTags"
            ],
            "Resource": "*",
            "Condition": {
              "StringEquals": {
              "ec2:CreateAction": "RunInstances"
              }
            }
        }
    ]
}
EOF
}

