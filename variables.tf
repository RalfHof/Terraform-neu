variable "ec2_instance_type" { 
  description = "Instance type for development"
  type        = string
  
}

variable "ami_id" {
  description = "AMI ID to use for the instances"
  type        = string
  default     = "ami-0084a47cc718c111a"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.0.0/20"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "ingress_rules" {
  description = "Ingress Rules for Security Group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "egress_rules" {
  description = "Egress Rules for Security Group"
  type = object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })
  default = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "apache_sg_name" {
  description = "Security group name for Apache server"
  type        = string
  default     = "allow_tls_80"
}

variable "mysql_sg_name" {
  description = "Security group name for MySQL server"
  type        = string
  default     = "mysql-sg"
}


