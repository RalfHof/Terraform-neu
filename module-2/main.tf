provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "einfacher_server" {
  instance_type = "t2.small"
  ami = "ami-0084a47cc718c111a"
  tags = {
    Name = "einfacher Server aus dem Module"
  }
}

output "module2output" {
  value = "hello from module 2"
}