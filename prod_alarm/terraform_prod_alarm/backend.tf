terraform {
  backend "s3" {
    bucket         = "s3-prod-terraform"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "s3-prod-terraform-state-lock"
  }
}