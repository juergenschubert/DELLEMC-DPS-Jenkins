# aws login information
variable "access_key" {
  type = string
}

variable "name_ws_iam_user" {
  type = string
}

variable "name_aws_s3_bucket" {
  type = string
}
variable "name_aws_iam_policy" {
  type = string
}

variable "aws-subnet-id" {
  type = string
}

variable "aws_s3_bucket" {
  type    = string
  default = "s3-bucket-ddve6-terraform"
}

variable "secret_key" {
  type = string
}
#region - where do you wanna install your ddve?
variable "aws_region" {
  type = string
  #  default = "eu-central-1"
}
#availabillity zone for region is aws
variable "availabillity_zone" {
  type = map(any)
  default = {
    "eu-central-1" = "eu-central-1a"
    "eu-west-3"    = "eu-west-3a"
    "eu-west-2"    = "eu-west-2a"
    "eu-west-1"    = "eu-west-1a"
  }
}

/*GOT replaced by data "aws_ami" "ddve6" in aws_instance.tf*/
# DDOS 7.4 CFT https://s3.amazonaws.com/awsmp-fulfillment-cf-templates-prod/3cc6672f-1de3-47d6-8eb2-31f9ebd815c7.e3029487-4435-4323-bbfc-c2c46be30106.template
# ami id for the DDVE ami to install. Another region? Add region name and dvve ami
# change the region in teraform.tf.vars  as well

variable "ami_id" {
  type = map
  default = {
    "us-east-1" = "ami-0311019605f7adcc7"
    "us-east-2" = "ami-0db894ac4985f19f9"
    "us-west-1" = "ami-013b145d3d093e02e"
    "us-west-2" = "ami-081977f49785f9e74"
    "eu-west-3" = "ami-0cd8d64d53de66160"
    "eu-west-2" = "ami-03e0b742c5af4052d"
    "eu-west-1" =  "ami-0de0f562fdaa91b53"
    "eu-central-1" = "ami-0b29b44df5b9a210b"
    "ap-south-1" = "ami-02adc49bf0e2d44b5"
    "ap-northeast-2" =  "ami-025d1f973b05e4610"
    "ap-northeast-1" =  "ami-0bee6172c007081ff"
    "ap-southeast-1" = "ami-05e407afa18e3fd64"
    "ap-southeast-2" = "ami-090b2fbb82247abda"
    "sa-east-1" = "ami-02d70622cdec5278c"
    "ca-central-1" =  "ami-07c8d5de75ab7808d"
    "us-gov-west-1" = "ami-074f60979b5e93eae"
    "us-gov-east-1" = "ami-0a57f9e5226fcd682"
    "eu-south-1" = "ami-06953647a6e496daf"
    "af-south-1" = "ami-01c7d113a1c96e00d"
	  "me-south-1" = "ami-06a1522d8890e6b61"
	  "eu-north-1" = "ami-0642b28dc70d858e5"
  }
}
/* */
#Instance type. Need to be changed into a map as we go ahead with different configs
# change the region in teraform.tf.vars  as well
variable "instance_type" {
  type = string
  # default = "m4.xlarge"
}

# variable for the ddve key pair name it is taking
# change the region in teraform.tf.vars  as well

variable "key_name" {
  type = string
}

# volume names for the ddve volumen
# with a new design this will get removed as they do look always the same
variable "ebs_volume_name" {
  type    = list(any)
  default = ["_Metadatadisk_1", "_Metadatadisk_2", "_Metadatadisk_3", "_Metadatadisk_4", "_Metadatadisk_5", "_Metadatadisk_6", "_Metadatadisk_7", "_Metadatadisk_8", "_Metadatadisk_9", "_Metadatadisk_10", "_Metadatadisk_11", "_Metadatadisk_12", "_Metadatadisk_13"]
}

#vaolume sizes for the individual volumes
variable "ebs_volume_size" {
  type = number
}
#mapping values of the volume. So _NVRAM got mapped to /dev/sdc
variable "ec2_device_names" {
  default = [
    "/dev/sdc",
    "/dev/sdd",
    "/dev/sde",
    "/dev/sdf",
    "/dev/sdg",
    "/dev/sdh",
    "/dev/sdi",
    "/dev/sdj",
    "/dev/sdk",
    "/dev/sdl",
    "/dev/sdm",
    "/dev/sdn",
    "/dev/sdo",
    "/dev/sdp",
    "/dev/sdq",
    "/dev/sdr"
  ]
}

# how many volumes do you wanna to be deployed
# new desging will make this more tight to the Metadisk volumes
/*variable "ec2_ebs_volume_count" {
  type = number
}
*/

variable "amount_of_metadisk" {
  type    = number
  default = 2
}

variable "ddve_name" {
  type    = string
  default = "dell-ddve-6"
}

variable "instance_name_tag" {
  type = string
  default = "DDVE-DDOS-7.4"
}
