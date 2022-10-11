terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">=0.14.9"
}
provider "aws" {
  access_key="xxxxxx"
secret_key="xxxxx"
  region  = "us-east-1"
}
resource "aws_instance" "example_instance" {
  ami           = "ami-0022f774911c1d690"
  instance_type = "t2.micro"

  tags = {
    "Name" = "example instance"
  }
}

data "aws_instance" "example_instance_2" {
  
   filter {
    name   = "tag:Name"
    values = ["example instance 2"]
  }
 
}

resource "aws_ec2_tag" "project" {
  resource_id = data.aws_instance.example_instance_2.id
  key = "Project"
  value = "personal"
}
