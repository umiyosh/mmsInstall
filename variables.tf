# variable "aws_access_key" {}
# variable "aws_secret_key" {}
provider "aws" {
  region = "${var.aws.region}"
}

variable "aws" {
  default = {
    region   = "ap-northeast-1"
    key_name = "REPLACE:umiyosh"
    vpc      = "REPLACE:vpc-xxxx"
  }
}

variable "aws_route53_zone" {
  default = "REPLACE:ZKXXXXXX"
}
variable "hosted_zone" {
  default = "REPLACE:umiyosh.com"
}

variable "subnets" {
  default = {
    private_mongod = "REPLACE:subnet-XXXXXX"
  }
}

variable "security_group" {
  default = "REPLACE:sg-XXXXXXXX"
}

# Update AMI of API server 1 by 1 to execute rolling updates
variable "amis" {
  default = {
    mms = "ami-7fefc411"
  }
}

variable "hostname" {
    default    = {
      mongod     = "mongod"
      mongod_arb = "mongod-arb"
      mongoc     = "mongoc"
      mongos     = "mongos"
    }
}

variable "prefix" {
    default = "mmstest"
}

variable "count" {
    default {
      mongod     = 4
      mongod_arb = 1
      mongoc     = 3
      mongos     = 2
    }
}
