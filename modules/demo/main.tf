## TODO: VPC should be part of another "backbone" module
resource "aws_vpc" "vpc_demo" {
  cidr_block = "172.16.0.0/16"
  tags = var.tags
}

resource "aws_subnet" "subnet_demo" {
  vpc_id     = aws_vpc.vpc_demo.id
  cidr_block = "172.16.10.0/24"  
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = var.tags
}


## TODO: Data section could not be nessasary. Check if value can be hardcoded or sent as variable
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


# Create a security group allowing SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.vpc_demo.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ip_whitelist
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_eip" "demo" {
    instance = aws_instance.demo.id
    domain = "vpc"
}

resource "aws_instance" "demo" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  associate_public_ip_address = true
  security_groups = [ aws_security_group.allow_ssh.name ]


  user_data = <<-EOF
#!/bin/bash
# serial = 2024031703
authorized_keys_file=/home/ubuntu/.ssh/authorized_keys
touch $authorized_keys_file
echo "${var.admin_ssh_public_key}" >> $authorized_keys_file
chmod 600 $authorized_keys_file
chown ubuntu:ubuntu $authorized_keys_file
  EOF

  tags = var.tags
}
