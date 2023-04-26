terraform {
  backend "s3" {
    bucket = "terraform-b4"
    region = "ap-south-1"
    key = "terraform.tfstate"
  }
}

provider "aws" {
    region = var.region
}
resource "aws_instance" "my-instance" {
    ami = var.ami.id
    instance_type = var.instance_type
    key_name = var.key_pair
    tags = var.tags
    vpc_security_group_ids = var.sg_ids
    }
    
       variable "region" {
         description = "please enter aws region" 
         default = "ap-south-1"
      }

      variable "instance_type" {
        description = "instance type"
        default = "t3.micro"
      }
      vari