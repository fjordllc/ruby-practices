data "aws_iam_policy" "this" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "this" {
  name = local.name
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "this" {
  name   = local.name
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy.this.policy
}


resource "aws_iam_instance_profile" "this" {
  name = local.name
  role = aws_iam_role.this.name
}


