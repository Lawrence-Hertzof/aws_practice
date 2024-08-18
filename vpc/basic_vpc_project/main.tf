terraform {
  #############################################################
  ## AFTER RUNNING TERRAFORM APPLY (WITH LOCAL BACKEND),
  ## YOU SHOULD APPLY THIS CODE BACKEND CODE THAT IS COMMENTED,
  ## THEN RERUN TERRAFORM INIT TO SWITCH FROM LOCAL BACKEND TO REMOTE AWS BACKEND
  #############################################################
#   backend "s3" {
#     bucket         = "sales-automation-terraform-state"
#     key            = "terraform.tfstate"
#     region         = "us-west-2"
#     dynamodb_table = "sales-automation-terraform-state-locking"
#     encrypt        = true
#   }

    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}

provider "aws" {
  region = var.aws_region
}

