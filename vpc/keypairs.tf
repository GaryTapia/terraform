resource "aws_key_pair" "GamingServerKeyPair" {
    key_name = "GamingServerKeyPair"
    public_key = "${file("${path.module}/GamingServerKeyPair.pub")}"
}