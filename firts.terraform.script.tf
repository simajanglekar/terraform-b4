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
   data "aws_security_group" "my_sg" {
    filter {
      name = "vpc-id"
      values = [ "vpc-029ae6ba0077aa2ef" ]
    }
    filter {
      name = "group-name"
      values = [ "default" ]
    }
     
   }
resource "aws_instance" "my-instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_pair
    tags = var.tags
    vpc_security_group_ids = [data.aws_security_group.my_sg.id]
    }
     
      variable "region" {
         description = "please enter aws region" 
         default = "ap-south-1"
      }
      variable "ami_id" {
        default = "ami-0763cf792771fe1bd"
}

     variable "instance_type" {
        description = "instance type"
        default = "t3.micro"
      }
      variable "key_pair" {
      default = "sima"
        
      }
      variable "tags" {
    type = map
    default = {
        env = "dev"
        Name = "my-instance"
    }
}

#variable "sg_ids" {
  #  type = list
  #  default = [
    #    "sg-09de3c34c106ef45d"
   # ]
#}

output "demo" {
value = "hellow sima"  
}

output "publice_ip" {
  value = aws_instance.my-instance.public_ip
  }

