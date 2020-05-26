resource "aws_launch_configuration" "basic_launchconfig" {
    name_prefix = "basic_launchconfig"
    image_id = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.GamingServerKeyPair.key_name}"
    security_groups = ["${aws_security_group.allow-ssh.id}"]
}

resource "aws_autoscaling_group" "basic-autoscaling" {
    name = "basic_autoscaling"
    vpc_zone_identifier = ["${aws_subnet.main-public-1.id}", "${aws_subnet.main-public-2.id}"]
    launch_configuration = "${aws_launch_configuration.basic_launchconfig.name}"
    min_size = 1
    max_size = 2
    health_check_grace_period = 300
    health_check_type = "EC2"
    force_delete = true

    tag {
        key = "Name"
        value = "ec2 instance"
        propagate_at_launch = true
    }
}

output "instance_ips" {
  value = ["${aws_autoscaling_group.basic-autoscaling.*}"]
}
