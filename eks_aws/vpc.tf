#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/vpc.html


resource "aws_vpc" "main" {
  # CIDR block for the VPC
  cidr_block = "192.168.0.0/16"

  #Makes instances shared on the host
  instance_tenancy = "default"

  # On/Off DNS support in the VPC. Needed for EKS
  enable_dns_support = true

  # On/Off DNS hostnames in the VPC. Needed for EKS
  enable_dns_hostnames = true

  # On/off ClassicLink for the VPC
  #enable_classiclink             = false
  #enable_classiclink_dns_support = false

  # No ipv6
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "main"
  }
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id."
  sensitive   = false
}
