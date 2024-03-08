resource "aws_iam_role" "cint-code-challenge-ssm-iam-role" {
  name               = "cint-code-challenge-ssm-iam-role"
  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": {
"Effect": "Allow",
"Principal": {"Service": "ec2.amazonaws.com"},
"Action": "sts:AssumeRole"
}
}
EOF
}

resource "aws_iam_instance_profile" "cint-code-challenge-ssm-iam-profile" {
  name = "cint-code-challenge-ssm-iam-profile"
  role = aws_iam_role.cint-code-challenge-ssm-iam-role.name
}

resource "aws_iam_role_policy_attachment" "cint-code-challenge-attach-ssm-policy" {
  role       = aws_iam_role.cint-code-challenge-ssm-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

