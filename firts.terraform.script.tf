provider "aws" {
    region = var.region
}
resource "aws_instance" "my-instance" {
    ami = var.ami.id
    instance_type = var.instance_type
    key_name = var.key_pair
    tags = {
        env = "dev"
        Name = "instance-1"
    }
        vpc_security_group_ids = ["sg-0ef6349993a032265" , "sg-09de3c34c106ef45d"]
    }
       variable "region" {
         description = "aws region" 
         default = "ap-south-1"
      }

      variable "instance_type" {
        description = "instance type"
        default = "t3.micro"
      }