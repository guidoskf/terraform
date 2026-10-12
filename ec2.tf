terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

# Busca automáticamente la última imagen oficial de Ubuntu 22.04 en us-west-1
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

  owners = ["099720109477"] # ID oficial del creador de Ubuntu (Canonical)
}

resource "aws_instance" "prueba" {
  count = 2
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  tags = {
    Name = "prueba"
  }
}
