terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
  }

  backend "s3" {
    bucket         = "kizzy-terraform-state"
    key            = "remote-state"
    region         = "ap-southeast-2"
    dynamodb_table = "state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region     = "ap-southeast-2"
  secret_key = ""
  access_key = ""
}