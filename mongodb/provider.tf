provider "aws" {
  profile = "mfa"
  region  = "us-east-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.11"
    }
  }
}