# DELLEMC DPS *terraform* with DDVE 6 and DDOS 7.4 on aws

Rename terraform.tfvars.examples into terraform.tfvars and fill in all values you need

This terraform script will create IAM polica and role to acces the s3 bucket which will also be created
an ec2 instance with the # of metadatadisk you have choosen in terraform.tfvars

In the current version I am not creating and VPC or subnet. This will come later.

Changing the S3 bucket-name will meant that you also have to update the json permission files to grant access to right S3-bucket-name  

Start the deployment
$git clone <the repos you need>
$cd <into the terraform dir>

$terraform init
$terraform plan
$terraform apply -auto-approve

deleting the instance with all it's components
§terraform destroy -auto-approve