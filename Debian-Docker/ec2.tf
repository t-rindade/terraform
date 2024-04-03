data "template_file" "user_data_ec2" {
  template = file("./scripts/docker.sh")
}

resource "aws_instance" "Debian" {
  ami                         = "ami-058bd2d568351da34"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-01c8e1535a8b083d8"
  key_name                    = "chaveppk"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Sec-Debian-Docker.id]
  user_data                   = base64encode(data.template_file.user_data_ec2.rendered)
  tags = {
    Name = "Debian-Docker"
  }
}

output "instance_public_ip_ec2" {
  description = "IP Publico da Instancia EC2"
  value       = aws_instance.Debian.public_ip
}

resource "aws_security_group" "Sec-Debian-Docker" {
  name   = "Sec-Debian-Docker"
  vpc_id = "vpc-025609655ce0bd440"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "icmp"
    from_port   = -1
    to_port     = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
