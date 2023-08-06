resource "aws_nat_gateway" "gw1" {
  #The allocation ID of the Elastic ip address for the internal gateway
  allocation_id = aws_eip.nat1.id
  #The subnet to place the internal gateway
  subnet_id = aws_subnet.public_1.id

  tags = {
    Name = "NAT 1"
  }
}


resource "aws_nat_gateway" "gw2" {
  #The allocation ID of the Elastic ip address for the internal gateway
  allocation_id = aws_eip.nat2.id
  #The subnet to place the internal gateway
  subnet_id = aws_subnet.public_2.id

  tags = {
    Name = "NAT 2"
  }
}