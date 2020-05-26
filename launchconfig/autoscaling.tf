
resource "aws_autoscaling_policy" "basic-cpu-policy" {
    name = "basic-cpu-policy"
    autoscaling_group_name = "${aws_autoscaling_group.basic-autoscaling.name}"
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = "1"
    cooldown = "300"
    policy_type = "SimpleScaling"
}

#Scale down alarm
resource "aws_autoscaling_policy" "basic-cpu-policy-scaledown" {
    name = "basic-cpu-policy-scaledown"
    autoscaling_group_name = "${aws_autoscaling_group.basic-autoscaling.name}"
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = "-1"
    cooldown = "300"
    policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "basic-cpu-alarm" {
    alarm_name = "basic-cpu-alarm"
    alarm_description = "basic-cpu-alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "30"

    dimensions = {
        "AutoScalingGroupName" = "${aws_autoscaling_group.basic-autoscaling.name}"
    }

    actions_enabled = true
    alarm_actions = ["${aws_autoscaling_policy.basic-cpu-policy.arn}"]
}
