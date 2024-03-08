resource "aws_launch_template" "cint-code-challenge-launch-template" {
  image_id      = "ami-07d9b9ddc6cd8dd30"
  instance_type = "t2.micro"
  user_data     = filebase64("${path.module}/ssm.sh")

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.cint-code-challenge-ec2-sg.id]
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.cint-code-challenge-ssm-iam-profile.name
  }
}
resource "aws_autoscaling_group" "cint-code-challenge-autoscaling-group" {
  # no of instances
  desired_capacity = 2
  max_size         = 2
  min_size         = 2

  # Connect to the target group
  target_group_arns = [aws_lb_target_group.cint-code-challenge-target-group.arn]

  vpc_zone_identifier = [ # Creating EC2 instances in private subnet
    aws_subnet.private[0].id, aws_subnet.private[1].id
  ]

  launch_template {
    id      = aws_launch_template.cint-code-challenge-launch-template.id
    version = "$Latest"
  }
}
