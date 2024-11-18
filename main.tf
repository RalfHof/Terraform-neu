provider "aws" {
  region = var.region
}

resource "aws_vpc" "main-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "project-18-11-2024-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw-main" {
  vpc_id = aws_vpc.main-vpc.id
}

resource "aws_route_table" "rt-main" {
  vpc_id = aws_vpc.main-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-main.id
  }
}

resource "aws_route_table_association" "rt-main-ass" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.rt-main.id
}

resource "aws_security_group" "apache_sg" {
  name        = var.apache_sg_name
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main-vpc.id

  # Ingress Rules
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Egress Rules
  egress {
    from_port   = var.egress_rules.from_port
    to_port     = var.egress_rules.to_port
    protocol    = var.egress_rules.protocol
    cidr_blocks = var.egress_rules.cidr_blocks
  }
}

resource "aws_security_group" "mysql_sg" {
  name        = var.mysql_sg_name
  description = "Allow MySQL inbound traffic"
  vpc_id      = aws_vpc.main-vpc.id

  # Ingress Rules
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Egress Rules
  egress {
    from_port   = var.egress_rules.from_port
    to_port     = var.egress_rules.to_port
    protocol    = var.egress_rules.protocol
    cidr_blocks = var.egress_rules.cidr_blocks
  }
}

resource "aws_instance" "apache-instance" {
  ami           = var.ami_id
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.public-subnet.id
  vpc_security_group_ids = [
    aws_security_group.apache_sg.id,
    aws_security_group.maintanance_ssh_access.id
  ]

  tags = {
    Name = "ApacheServer"
  }
}

resource "aws_instance" "db-instance" {
  ami           = var.ami_id
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.public-subnet.id
  vpc_security_group_ids = [
    aws_security_group.mysql_sg.id,
    aws_security_group.maintanance_ssh_access.id
  ]

  tags = {
    Name = "DBServer"
  }
}

output "public-ip-db" {
  description = "The public ip of the DB"
  value       = aws_instance.db-instance.public_ip
}

output "public-ip-apache" {
  description = "The public ip of the Apache Webserver"
  value       = aws_instance.apache-instance.public_ip
}

resource "aws_security_group" "maintanance_ssh_access" {
  name        = "ssh_access_group"
  description = "Allow SSH access on port 22"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

