provider "aws" {
    region = "us-west-2"
    shared_credentials_file = "C:\\Users\\Gurry\\.aws\\creds.txt"
}

data "aws_ami" "ubuntu" {
    most_recent = true


    filter {
        name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # This is Cannonical
}

resource "aws_instance" "web" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"

    tags = {
        Name = "UbuntuServer"
    }
}