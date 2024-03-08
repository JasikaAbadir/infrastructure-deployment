locals {
  tags = {
    project = var.name
  }
}


locals {
  private_subnets_id = [
    aws_subnet.private[0].id, aws_subnet.private[1].id
  ]
}