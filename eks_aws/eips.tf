#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip

resource "aws_eip" "nat1" {
  # eip needs internet-gateway before creation.
  depends_on = [aws_internet_gateway.main]

}


resource "aws_eip" "nat2" {
  # eip needs internet-gateway before creation.
  depends_on = [aws_internet_gateway.main]

}