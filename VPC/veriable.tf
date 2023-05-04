variable "region"{
    default = "eu-west-2"
}
variable "az1" {
    default = "eu-west-2a"
}

variable "az2" {
    default = "eu-west-2b"
}
variable "terraform-backend"{
    default = "terraform-backend-b4"
}

variable "vpc_cidr" {
    default = "10.10.0.0/16"
}

variable "env" {
    default = "dev"
}

variable "pri_sub_cidr" {
    default = "10.10.0.0/20"
}

variable "project" {
    default = "cbz"
}

variable "pub_sub_cidr" {
    default = "10.10.16.0/20"
}

variable "image_id" {
    default = "ami-036e229aa5fa198ba"
}
 variable "instance_type" {
    default = "t2.micro"
 }

variable "key_pair" {
    default = "aditya-london"
}

