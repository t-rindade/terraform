data "template_file" "user_data_ec2" {
  template = file("./scripts/ubuntu.sh")
}

resource "aws_instance" "Ubuntu" {
  ami                         = "ami-080e1f13689e07408"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-045e8c5ce6544fcc4"
  key_name                    = "chaveppk"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Sec-Ubuntu-Apache.id]
  user_data                   = base64encode(data.template_file.user_data_ec2.rendered)
  tags = {
    Name = "Ubuntu-Apache"
  }
}

output "instance_public_ip_ec2" {
  description = "IP Publico da Instancia EC2"
  value       = aws_instance.Ubuntu.public_ip
}

resource "aws_security_group" "Sec-Ubuntu-Apache" {
  name   = "Sec-Ubuntu-Apache"
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
