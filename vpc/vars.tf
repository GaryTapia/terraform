variable "AWS_REGION" {
  default = "us-west-2"
}

variable "AMIS" {
  type = "map"
  default = {
    us-west-2 = "ami-06ffade19910cbfc0"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "~/.ssh/GamingServerKeyPair"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "GamingServerKeyPair"
  
}

