variable "region"{
    default = "ap-south-1a"
}
variable "az1" {
    default = "ap-south-1b"
}

variable "az2" {
    default = "ap-south-1c"
}
variable "terraform-backend"{
    default = "terraform-b4"
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
    default = "sima"
}

