#s4 bucket where the data will be stored from the DDVE
# need to change the naming convenetion to include instance type
resource "aws_s3_bucket" "ddve6" {
  bucket        = "ddve6-bucket-terraform"
  force_destroy = true
}
