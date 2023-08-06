#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

resource "aws_subnet" "public_1" {
  cidr_block        = "192.168.0.0/18"
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2a"

  # Ec2 instances will assigned a public ip address on lunch. EKS needs this.
  map_public_ip_on_launch = true

  #allows kubernetes to discover the correct public subnet
  tags = {
    Name                        = "public-us-east-2a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "public_2" {
  cidr_block        = "192.168.64.0/18"
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2b"

  # Ec2 instances will assigned a public ip address on lunch. EKS needs this.
  map_public_ip_on_launch = true

  #allows kubernetes to discover the correct public subnet
  tags = {
    Name                        = "public-us-east-2b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "private_1" {
  cidr_block        = "192.168.128.0/18"
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2a"


  tags = {
    Name                              = "private-us-east-2a"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "private_2" {
  cidr_block        = "192.168.192.0/18"
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-2b"


  tags = {
    Name                              = "private-us-east-2b"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}