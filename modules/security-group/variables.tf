variable "name" {
  type        = string
  description = "Name of the security group"
}

variable "description" {
  type        = string
  description = "Description of the security group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the security group"
}

variable "ingress_from_port" {
  type        = number
  description = "Ingress rule from port"
}

variable "ingress_to_port" {
  type        = number
  description = "Ingress rule to port"
}

variable "ingress_protocol" {
  type        = string
  description = "Ingress protocol"
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "Ingress CIDR blocks"
}

variable "egress_from_port" {
  type        = number
  description = "Egress rule from port"
}

variable "egress_to_port" {
  type        = number
  description = "Egress rule to port"
}

variable "egress_protocol" {
  type        = string
  description = "Egress protocol"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "Egress CIDR blocks"
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
