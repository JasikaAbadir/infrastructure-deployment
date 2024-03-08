resource "aws_instance" "cint-code-challenge-servers" {
  count = 2
  ami           = "ami-07d9b9ddc6cd8dd30"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.cint-code-challenge-ssm-iam-profile.name
  vpc_security_group_ids = [aws_security_group.cint-code-challenge-ec2-sg.id]
  subnet_id = element(local.private_subnets_id, count.index)
  user_data = file("${path.module}/ssm.sh")


}