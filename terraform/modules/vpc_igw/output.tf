output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_name" {
  value = var.vpc_name
}

output "igw_id" {
  value = aws_internet_gateway.main.id
}