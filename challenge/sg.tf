### alb security group ###

resource "aws_security_group" "cint-code-challenge-alb-sg" {
  name        = "cint-code-challenge-alb-sg"
  description = "Load balancer security group"

  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allowing traffic from anywhere (HTTP)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

### ec2 security group ###

resource "aws_security_group" "cint-code-challenge-ec2-sg" {
  name        = "cint-code-challenge-ec2-sg"
  description = "ec2 security group allowing ingress traffic from loadbalancer"

  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.cint-code-challenge-alb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

### RDS security group ###

resource "aws_security_group" "cint-code-challenge-db-sg" {
  name        = "cint-code-challenge-db-sg"
  description = "db security group allowing ingress traffic from ec2"

  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.cint-code-challenge-ec2-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}