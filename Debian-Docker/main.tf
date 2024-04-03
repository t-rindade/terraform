terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.42.0"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["C:/Users/47103853860/.aws/config"]
  shared_credentials_files = ["C:/Users/47103853860/.aws/credentials"]

  default_tags {
    tags = {
      owner   = "Trindade"
      maneged = "Terraform134"
    }
  }

}
