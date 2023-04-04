terraform {
  backend "s3" {
    bucket = "mweitz-tfstate-remote"
    key    = "projects/website/terraform.tfstate"
    region = "us-east-2"
  }
}