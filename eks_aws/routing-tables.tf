#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    #The CIDR block of the route.
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC iGw
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.main.id

  route {
    #The CIDR block of the route.
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC iGw
    gateway_id = aws_nat_gateway.gw1.id
  }

  tags = {
    Name = "private1"
  }
}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.main.id

  route {
    #The CIDR block of the route.
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC iGw
    gateway_id = aws_nat_gateway.gw2.id
  }

  tags = {
    Name = "private2"
  }
}