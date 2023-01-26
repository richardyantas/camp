terraform {
  backend "gcs" {    
    bucket  = "tf-state-prod"
    prefix  = "terraform/state"
    # prefix          = "bastion/terraform.tfstate"
    # bucket          = "tfstate-bucket-4291-ideasextraordinarias-default"
  }
}