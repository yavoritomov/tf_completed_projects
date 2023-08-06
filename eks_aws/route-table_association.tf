#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association

resource "aws_route_table_association" "public1" {
  # The ID of teh table to associate with.
  route_table_id = aws_route_table.public.id
  # The subnet ID to create an association
  subnet_id = aws_subnet.public_1.id
}

resource "aws_route_table_association" "public2" {
  # The ID of teh table to associate with.
  route_table_id = aws_route_table.public.id
  # The subnet ID to create an association
  subnet_id = aws_subnet.public_2.id
}

resource "aws_route_table_association" "private1" {
  # The ID of teh table to associate with.
  route_table_id = aws_route_table.private1.id
  # The subnet ID to create an association
  subnet_id = aws_subnet.private_1.id
}

resource "aws_route_table_association" "private2" {
  # The ID of teh table to associate with.
  route_table_id = aws_route_table.private2.id
  # The subnet ID to create an association
  subnet_id = aws_subnet.private_2.id
}