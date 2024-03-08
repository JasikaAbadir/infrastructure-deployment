resource "random_password" "cint-code-challenge-random-password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "cint-code-challenge-password_identifier" {
  name = "cint-code-challenge-db-password1"
}

resource "aws_secretsmanager_secret_version" "cint-code-challenge-password" {
  secret_id     = aws_secretsmanager_secret.cint-code-challenge-password_identifier.id
  secret_string = random_password.cint-code-challenge-random-password.result
}