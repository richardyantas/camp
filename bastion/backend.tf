terraform {
  backend "gcs" {    
    bucket  = "sc_jenkins_terraform_tes2"
    # prefix  = "terraform/state"
    # prefix          = "bastion/terraform.tfstate"
    # bucket          = "tfstate-bucket-4291-ideasextraordinarias-default"
  }
}