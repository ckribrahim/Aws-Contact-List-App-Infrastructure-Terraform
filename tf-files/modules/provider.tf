terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.11.1"
    }
  }
}



provider "github" {
  # Configuration options
  token=data.aws_ssm_parameter.ornek_parametre.value
}