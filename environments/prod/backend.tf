terraform {
  backend "s3" {
    bucket = "cleanora-terraform-state"
    key    = "prod/terraform.tfstate"
    region = "eu-central-1"
  }
}