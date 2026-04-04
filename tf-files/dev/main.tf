terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
  }
  backend "s3" {
    bucket = "contactlist-backend-bravosix"
    key = "env/dev/tf-remote-backend.tfstate"
    region = "us-east-1"
    dynamodb_table = "tf-s3-app-lock"
    encrypt = true
  }
}


module "contactlist" {
  source   = "../modules"
  git-user = "ckribrahim"
  key-name = "cpt"
  hosted-zone = "ibrahimcakir.online"
  env = "dev"
}

output "websiteurl" {
  value = module.contactlist.websiteurl
}