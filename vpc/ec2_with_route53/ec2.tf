resource "aws_instance" "example_ec2_private_instance" {
  ami = "ami-0aff18ec83b712f05"
  instance_type = "t2.micro"
  key_name = aws_key_pair.new_bastion_key.key_name
  subnet_id = aws_subnet.subnet_a_public.id
  security_groups = [aws_security_group.ssh_and_http_security_group_terraform_practice.id]

  provisioner "remote-exec" {
    when = create
    inline = [
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = "${file("./ssh_keys/new_key.pem")}"
  }
  

  tags = {
    Name = "example-ec2-public-terraform-practice"
  }
}


### SECOND EC2 INSTANCE ###
resource "aws_instance" "example_ec2_private_instance_b" {
  ami = "ami-0aff18ec83b712f05"
  instance_type = "t2.micro"
  key_name = aws_key_pair.new_bastion_key.key_name
  subnet_id = aws_subnet.subnet_b_public.id
  security_groups = [aws_security_group.ssh_and_http_security_group_terraform_practice.id]

  provisioner "remote-exec" {
    when = create
    inline = [
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = "${file("./ssh_keys/new_key.pem")}"
  }
  

  tags = {
    Name = "example-ec2-public-b-terraform-practice"
  }
}