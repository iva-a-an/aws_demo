terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "tf-demo-concrete-gull" ## TODO : See intit statte for the reference
    key            = "terraform/dev.project_demo.tfstate"
    region         = "us-east-1"
  }

}

provider "random" {}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" ## TODO : Change the region to be Global variable
}


