provider "aws" {
  region = var.region
}

resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "project-18-11-2024-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
}

resource "aws_security_group" "maintanance_ssh_access" {
  count       = var.allow_ssh ? 1 : 0
  name        = "ssh_access_group"
  description = "allow ssh access on port 22"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
