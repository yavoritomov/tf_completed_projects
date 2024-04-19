[all_linux]
%{ for ip in ec2_public_ip ~}
${ip}
%{ endfor ~}

[all_linux:vars]
ansible_ssh_user = ubuntu
ansible_ssh_private_key_file=/mnt/c/Users/ytomov/Documents/github/terraform-course/ec2_ssh/aws_key