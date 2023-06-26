resource "aws_instance" "k3s_instance" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_key_pair
  vpc_security_group_ids = var.ec2_security_groups

  root_block_device {
    volume_size           = var.ec2_os_disk_size
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "k3s_node"
  }
}


resource "null_resource" "k3s_local_exec" {
  depends_on = [aws_instance.k3s_instance]

  triggers = {
    ec2_instance_id = aws_instance.k3s_instance.id
  }

  provisioner "local-exec" {
    command = <<EOF
      until nc -z -v -w5 ${aws_instance.k3s_instance.public_ip} 22; do sleep 5; done
      mkdir -p ~/.kube
      k3sup install --ip ${aws_instance.k3s_instance.public_ip} --user ubuntu --local-path ~/.kube/config --ssh-key ${var.ssh_key_path}
      echo '${aws_instance.k3s_instance.public_ip}' > ../terraform-deploy/instance_public_ip.txt
    EOF
  }
}

