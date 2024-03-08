resource "aws_lb" "cint-code-challenge-alb" {
  name               = "cint-code-challenge-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.cint-code-challenge-alb-sg.id]
  subnets            = [aws_subnet.public[0].id, aws_subnet.public[1].id]
}

resource "aws_lb_target_group" "cint-code-challenge-target-group" {
  name        = "cint-code-challenge-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id

  health_check {
    enabled             = true
    interval            = 10 # time between health checks
    path                = "/"
    port                = "traffic-port" # uses same port as target group
    protocol            = "HTTP"
    timeout             = 8
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "cint-code-challenge-alb-listener" {
  load_balancer_arn = aws_lb.cint-code-challenge-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cint-code-challenge-target-group.arn
  }
}

resource "aws_lb_target_group_attachment" "cint-code-challenge-ec2-target-group-attach" {
  count            = length(aws_instance.cint-code-challenge-servers)
  target_group_arn = aws_lb_target_group.cint-code-challenge-target-group.arn
  target_id        = aws_instance.cint-code-challenge-servers[count.index].id
}

