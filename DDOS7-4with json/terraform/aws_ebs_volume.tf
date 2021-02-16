#create the nvram disk first
resource "aws_ebs_volume" "nvram" {
  availability_zone = "${var.aws_region}a"
  #  availability_zone = lookup(var.availabillity_zone, var.region)
  size = 10
  type = "gp2"
  tags = {
    Name = "_NVRAM"
  }
}
#attach the nvram disk
resource "aws_volume_attachment" "attach_nvram" {
  volume_id   = aws_ebs_volume.nvram.id
  device_name = "/dev/sdb"
  instance_id = aws_instance.terraform_ddve.id
}
# create the metadatadisk - amount definded in terraform.tfvars
resource "aws_ebs_volume" "ebs_volume" {
  count = var.amount_of_metadisk
  #  availability_zone = lookup(var.availabillity_zone, var.region)
  availability_zone = "${var.aws_region}a"
  size              = var.ebs_volume_size
  type              = "gp2"
  tags = {
    Name = element(var.ebs_volume_name, count.index)
  }
}
# attach the volume to the instance
resource "aws_volume_attachment" "volume_attachement" {
  count       = var.amount_of_metadisk
  volume_id   = aws_ebs_volume.ebs_volume.*.id[count.index]
  device_name = element(var.ec2_device_names, count.index)
  instance_id = aws_instance.terraform_ddve.id
  depends_on  = [aws_ebs_volume.ebs_volume[0]]
}
