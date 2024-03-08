resource "aws_db_instance" "cint-code-challenge-db" {
  allocated_storage    = 10
  db_name              = "cintcodechallengedb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "dbadmin"
  password             = random_password.cint-code-challenge-random-password.result
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.cint-code-challenge-db-subnets.name
  vpc_security_group_ids = [aws_security_group.cint-code-challenge-db-sg.id]
  multi_az = false

  depends_on = [ aws_secretsmanager_secret_version.cint-code-challenge-password ]
}

resource "aws_db_subnet_group" "cint-code-challenge-db-subnets" {
  name       = "cint-code-challenge-db-subnets"
  subnet_ids = [aws_subnet.private[0].id, aws_subnet.private[1].id]

}