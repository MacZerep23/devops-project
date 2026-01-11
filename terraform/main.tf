provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "devops_ec2" {
  ami           = "ami-0df7a207adb9748c7" # Amazon Linux 2 (Singapore)
  instance_type = "t2.micro"
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -aG docker ec2-user

              curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
              -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose
              EOF

  tags = {
    Name = "DevOps-Project"
  }
}