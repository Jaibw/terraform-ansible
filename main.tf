provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "yourname" {
  ami = "ami-053ac55bdcfe96e85"
  instance_type = "t2.medium"
  key_name = "jai-wsl2-key"
  security_groups = ["website-demo"]
  tags = {
    Name = "yourname"
  }
  provisioner "local-exec" {
    command = "sleep 120 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.public_ip},' deploy.yaml"
  }
}

output "yourname" {
  value = "${aws_instance.yourname.public_ip}"
}
