##
### IAM Role
##
resource "aws_iam_role" "iam_role_terraform" {
  name               = "iam_role_ddve6_terraform"
  assume_role_policy = file("ddverolepolicy.json")
}


##
### IAM Profile
##
resource "aws_iam_policy" "iam_policy_terraform" {
  name        = "s3_ddve_iam_policy_ddve6_terraform"
  path        = "/"
  description = "Policy for s3 Storage acccess of our DELL DDVE"
  policy      = file("ddvepolicy.json")
}
##
### IAM role poliy attachment
##
resource "aws_iam_role_policy_attachment" "assign-policy_terraform" {
  role       = aws_iam_role.iam_role_terraform.name
  policy_arn = aws_iam_policy.iam_policy_terraform.arn
}

##
###  instance_profile
##
resource "aws_iam_instance_profile" "instance_profile_terraform" {
  name = "instance_profile_terraform"
  role = aws_iam_role.iam_role_terraform.name
}
