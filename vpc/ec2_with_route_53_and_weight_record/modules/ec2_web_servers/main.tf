resource "aws_instance" "this" {
  count = var.ec2_instance_count
  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  key_name = var.ec2_key_name
  subnet_id = var.ec2_subnets[count.index]
  security_groups = var.ec2_security_groups

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
    user        = var.ec2_ami == "ami-0aff18ec83b712f05" ? "ubuntu" : "ec2-user"
    password    = ""
    private_key = "${file(var.ec2_key_path)}"
  }

  tags = {
    Name = "${var.ec2_instance_name}[${tostring(count.index)}]"
  }
}