terraform {
    backend "s3" {
        bucket = "terraform-backend-b4"
        region = "ap-south-1"
        key = "terrform.tfstate"
    }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.project}-vpc"
        env = var.env
    }
}

resource "aws_subnet" "pri_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.pri_sub_cidr
    availability_zone = var.az1
    tags = {
        Name = "${var.project}-private-subnet"
        env = var.env
    }
}

resource "aws_subnet" "pub_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.pub_sub_cidr
    availability_zone = var.az2
    tags = {
        Name = "${var.project}-public-subnet"
        env = var.env
    }
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "${var.project}-igw"
        env = var.env
    }
}

resource "aws_default_route_table" "main_rt" {
    default_route_table_id = aws_vpc.my_vpc.default_route_table_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }
    tags = {
        Name = "${var.project}-rt"
        env = var.env
    }
}

resource "aws_security_group" "sg1" {
    name        = "${var.project}-sg"
    vpc_id      = aws_vpc.my_vpc.id
    description = "Allow http and https service"

    ingress {
        protocol = "tcp"
        from_port = 80
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        protocol = "tcp"
        from_port = 443
        to_port = 443
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
    depends_on = [
        aws_vpc.my_vpc
    ]
}



resource "aws_instance" "instance1" {
    ami = var.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_vpc.my_vpc.default_security_group_id, aws_security_group.sg1.id]
    subnet_id =  aws_subnet.pri_subnet.id
    key_name = var.key_pair
    tags = {
        Name = "${var.project}-private-instance"
        env = var.env
    }
    depends_on = [
        aws_security_group.sg1
    ]
}

/*
resource "aws_instance" "instance2" {
    ami = var.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_vpc.my_vpc.default_security_group_id, aws_security_group.sg1.id]
    subnet_id =  aws_subnet.pub_subnet.id
    key_name = var.key_pair
    tags = {
        Name = "${var.project}-public-instance"
        env = var.env
    }
    user_data = <<-EOF
        #!/bin/bash
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        echo "<h1> Hello World" > /var/www/html/index.html
    EOF
    depends_on = [
        aws_security_group.sg1
    ]
}
*/
