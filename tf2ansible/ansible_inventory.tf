resource "local_file" "hosts_cfg" {
  content = templatefile("./template/hosts.tpl",
    {
      ec2_public_ip = aws_instance.ec2_example.*.public_ip
    }
  )
  filename = "./ansible/inventory_ec2.ini"
}