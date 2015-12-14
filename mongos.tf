# mongos
resource "aws_instance" "umitest_mongos" {
  ami = "${var.amis.mms}"
  count = "${var.count.mongos}"
  instance_type = "t2.small"
  key_name = "${var.aws.key_name}"
  security_groups = ["${var.security_group}","${aws_security_group.default.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  subnet_id = "${var.subnets.private_mongod}"
  user_data = "${file("user_data/mongod.sh")}"
  associate_public_ip_address = true
  root_block_device = {
    volume_type = "gp2"
    volume_size = 40
    delete_on_termination = "1"
  }
  tags {
    Name = "${var.prefix}-${var.hostname.mongos}-${format("%02d", count.index+1)}"
  }
}

