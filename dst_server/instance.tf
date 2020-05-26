resource "aws_instance" "dontstarvetogether_ubuntu" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"

    #VPC Subnet
    subnet_id = "${aws_subnet.main-public-1.id}"

    #Security Group
    vpc_security_group_ids = ["${aws_security_group.DST-Ports.id}"]


    #Public SSH key
    key_name = "${aws_key_pair.GamingServerKeyPair.key_name}"

    #userdata
    user_data = "${data.template_cloudinit_config.cloudinit-example.rendered}"
    

    tags = {
        Name = "dontstarvetogetherubuntu-instance"
    }
}

resource "aws_ebs_volume" "ebs-volume-1" {
    availability_zone = "us-west-2b"
    size = 20
    type = "gp2"
    tags = {
        Name = "extra volume data"
    }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
    device_name = "/dev/xvdh"
    volume_id = "${aws_ebs_volume.ebs-volume-1.id}"
    instance_id = "${aws_instance.dontstarvetogether_ubuntu.id}"
}

output "instance_ips" {
  value = ["${aws_instance.dontstarvetogether_ubuntu.*.public_ip}"]
}

