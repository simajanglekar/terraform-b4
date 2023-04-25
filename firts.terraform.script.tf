provider "aws" {
    region = "ap-south-1"
}
resource "aws_instance" "my-instance" {
    ami = "ami-0763cf792771fe1bd"
    instance_type = "t3.micro"
    key_name = "sima"
    tags = {
        env = "dev"
        Name = "instance-1"
    }
        vpc_security_group_ids = ["sg-0ef6349993a032265" , "sg-09de3c34c106ef45d"]
    }
