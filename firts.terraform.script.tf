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
         description = "plese aws region" 
         default = "ap-south-1"
      }

      variable "instance_type" {
        description = "instance type"
        default = "t3.micro"
      }