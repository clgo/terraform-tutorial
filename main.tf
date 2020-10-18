terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
    region      = "us-east-1"
    access_key  = "your_access_key"
    secret_key  = "your_secret_key"
}

# Resource Declarations same format for any providers
/*
resource "<provider>_<resource_type>" "name" {
    config options....
    key = "value"
    key2 = "another value"
}
*/

# Create a EC2
# resource "aws_instance" "my-first-server" {
#   ami           = "ami-098f16afa9edf40be"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "First VM RHEL Terraform"
#     Application = "Web Server"
#     Zone = "SIT"
#   }
# }

# Create a VPC
resource "aws_vpc" "PROD" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production"
  }
}

# Create subnet in VPC
resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.PROD.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "prod-subnet"
  }
}

# Create a Second VPC
resource "aws_vpc" "DEV" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Development"
  }
}

# Create subnet in VPC
resource "aws_subnet" "subnet-2" {
  vpc_id     = aws_vpc.DEV.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "dev-subnet"
  }
}