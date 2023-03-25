provider "aws" {
   region     = "us-east-2"
   profile = "mfa"

}

resource "aws_instance" "ec2_example" {
    count = 2
    ami = "ami-0fb653ca2d3203ac1"
    instance_type = "t2.micro"
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]
    tags = {
      Name = "ansible-${count.index}"
    }

  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("aws_key")
      timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDce1OpPxmepJCrsX97B+yFTW0HR0d/6jXDoFZkO1lH2ho3TFYQPEDVISK9+jOUnrmRwQk5TMy5jgh1OzHVgOHbfGCF/tcsFIG46Cldrv9cPtcY6Gox+7M8LZgg2ZH4m5s5YzuA6YGdDpCdbDJlqVyggtEExm8WIohCLaMgwFhxlFdEOmGNKQigDZuNJHjTpweCZFulRz0UtgQEVhUt9ViLhuPah9ccFg9RBPITgZCMQtbS2Yidywd2Dv4WCqtVd5FuC/vqstQ77H9/+nD1mSU34nC+nwv/dZfETd0G4anV8QDCrO3MGdqWOjzFIsRfhTo3g+hqnmyUbpxTxSqFi3q9 ytomov@TS-WS03"
}


output "instance_public_ip" {
  value = aws_instance.ec2_example[*].public_ip
}