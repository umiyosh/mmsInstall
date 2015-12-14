# mongoc
resource "aws_instance" "umitest_mongoc" {
  ami = "${var.amis.mms}"
  count = "${var.count.mongoc}"
  instance_type = "t2.micro"
  key_name = "${var.aws.key_name}"
  security_groups = ["${var.security_group}","${aws_security_group.default.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  subnet_id = "${var.subnets.private_mongod}"
  user_data = "${file("user_data/mongod.sh")}"
  associate_public_ip_address = true
  root_block_device = {
      volume_type = "gp2"
      volume_size = 20
      delete_on_termination = "1"
  }
  tags {
    Name = "${var.prefix}-${var.hostname.mongoc}-${format("%02d", count.index+1)}"
  }
}

# DNS for internal
resource "aws_route53_record" "umitest_route53_mongoc" {
  count = "${var.count.mongoc}"
  zone_id = "${var.aws_route53_zone}"
  name = "${var.prefix}-${var.hostname.mongoc}-${format("%02d", count.index+1)}.${var.hosted_zone}"
  records = ["${element(aws_instance.umitest_mongoc.*.private_dns, count.index)}"]
  type = "CNAME"
  ttl = 60
}

