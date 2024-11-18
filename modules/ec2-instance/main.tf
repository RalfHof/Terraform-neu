# EC2-Instanz erstellen
resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [
    module.security_group.security_group_id
  ]
  tags = {
    Name = "EC2-Instance"
  }
}

# Output für die öffentliche IP der EC2-Instanz
output "ec2_public_ip" {
  value = aws_instance.ec2.public_ip
}

# Output für die Instance ID der EC2-Instanz
output "instance_id" {
  value = aws_instance.ec2.id
}

# Variablen für das EC2-Modul
variable "ami_id" {
  description = "AMI ID für die EC2-Instanz"
  type        = string
}

variable "instance_type" {
  description = "Instanztyp der EC2-Instanz"
  type        = string
}

variable "subnet_id" {
  description = "ID des Subnetzes"
  type        = string
}

variable "security_group_ids" {
  description = "ID(s) der Sicherheitsgruppen für die EC2-Instanz"
  type        = list(string)
}

variable "name" {
  description = "Name der EC2-Instanz"
  type        = string
}
