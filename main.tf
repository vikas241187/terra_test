provider "aws" {
region = "us-east-1"
}
resource "aws_instance" "git_instance" {
ami = "ami-05b10e08d247fb927"
instance_type = "t2.micro"
tags = {
Name = "Git-instance"
}
}
resource "aws_ebs_volume" "git-vol" {
size = var.env == "prod" ? 8 : 4
aws_insatance_id = aws_instance.git_instance.id
volume_id = aws_ebs_volume.git-vol.id
availability_zone = var.az
tags ={
Name = "git-vol"
}
}
resource "aws_volume_attachment" "vol-attach" {
device_name = "/dev/sdf"
aws_insatance_id = aws_instance.git_instance.id
volume_id = aws_ebs_volume.git-vol.id
}

