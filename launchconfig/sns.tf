#Must be manually subscribed to within AWS Console
resource "aws_sns_topic" "basic-cpu-sns" {
    name = "sg-cpu-sns"
    display_name = "basic ASG SNS topic"
} 


resource "aws_autoscaling_notification" "basic-notify" {
    group_names = ["${aws_autoscaling_group.basic-autoscaling.name}"]
    topic_arn = "${aws_sns_topic.basic-cpu-sns.arn}"
    notifications = [
      "autoscaling:EC2_INSTANCE_LAUNCH",
      "autoscaling:EC2_INSTANCE_TERMINATE",
      "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
      "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
}