terraform {
  backend "s3" {
    bucket         = "atlascloud-tf-state"
    key            = "dev/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}