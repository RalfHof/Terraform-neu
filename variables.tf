variable "availability_zone" {
  description = "Availability Zone for the resources"
  type        = string
  default     = "eu-central-1a"
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.0.0/20"
}


