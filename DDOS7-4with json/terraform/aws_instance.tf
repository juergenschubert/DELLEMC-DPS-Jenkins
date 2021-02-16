#1. creating an AWS IAM role using terraform.
#2. creating an IAM policy using terraform.
#3. attaching the policy to the role using terraform.
#4. creating the IAM instance profile using terraform.
#5. Assigning the IAM role, to an EC2 instance on the fly using terraform.
#https://medium.com/@kulasangar/creating-and-attaching-an-aws-iam-role-with-a-policy-to-an-ec2-instance-using-terraform-scripts-aa85f3e6dfff

#find the latest DDVE image in your region
#data "aws_ami" "ddve6" {
#  most_recent = true
#  owners      = ["aws-marketplace"]
#  filter {
#    name   = "name"
#    values = ["ddve-7.3.0.5-663138-GA-3cc6672f-1de3-47d6-8eb2-31f9ebd815c7-ami-002eeb5ba32bd2e9d.4"]
#  }
#}

resource "aws_instance" "terraform_ddve" {
  #ami = data.aws_ami.ddve6.id
  ami = lookup(var.ami_id, var.aws_region)
  instance_type = var.instance_type
  # subnet the instance runs into
  subnet_id = var.aws-subnet-id
  # key name
  key_name = var.key_name

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.ddvesg.id]
  # tighten things up with the instance profile
  iam_instance_profile = aws_iam_instance_profile.instance_profile_terraform.name
  ### delete associated ec2 disks
  root_block_device {
    delete_on_termination = true
  }
  tags = {
    Name = var.instance_name_tag
  }
  
  # before we can start or create a ressource we need:
  depends_on = [aws_security_group.ddvesg, aws_s3_bucket.ddve6, aws_ebs_volume.ebs_volume[0]]

  #let's write some information into a file so we can use it after the terraform apply again
  provisioner "local-exec" {
    command = "echo DataDomain IP and DNS Information >DDVE_config_info.txt"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.terraform_ddve.public_ip} >>DDVE_config_info.txt"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.terraform_ddve.public_dns} >>DDVE_config_info.txt"
  }
  provisioner "local-exec" {
    command = "echo S3 bucket name for DDDVE config >>DDVE_config_info.txt"
  }
  provisioner "local-exec" {
    command = "echo ${aws_s3_bucket.ddve6.bucket} >>DDVE_config_info.txt"
  }
  provisioner "local-exec" {
    command = "echo The aws instance ID is the sysadmin Password for the first login>>DDVE_config_info.txt"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.terraform_ddve.id} >>DDVE_config_info.txt"
  }

}
locals {
    someVariable = templatefile("template.tpl", {
        dd_ip = aws_instance.terraform_ddve.public_ip, 
        dd_password = aws_instance.terraform_ddve.id
        s3_bucket_name = aws_s3_bucket.ddve6.bucket
    })
}

output "neededForAnsible" {
  value = local.someVariable
}