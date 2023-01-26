terraform {
  backend "gcs" {    
    prefix          = "bastion/terraform.tfstate"
    bucket          = "tfstate-bucket-4291-ideasextraordinarias-default"
  }
}