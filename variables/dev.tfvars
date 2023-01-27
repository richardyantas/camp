/************************************************************************************************************************************************************
# Variables
************************************************************************************************************************************************************/
#################################################################################################### 
#  
#
####################################################################################################

gcp_vpc_name = "vpc-sc-jenkins-terraform-des"
gcp_subnet_1 = "subnet-vpc-sc-jenkins-terraform-des"
gcp_region = "europe-west1"
gcp_project_id = "jovial-atlas-375801"
client = "sc-jenkins-terraform"
gcp_vpc_cidr = "172.31.0.0/16"  # Ipv4 range = 10.0.0.0/24
gcp_zone = "europe-west1"
# zones = ["europe-west3a","europe-west3b","europe-west3c"]

# vm - BASTION ---------------------------
cidr_blocks = "0.0.0.0/0"
machine_type = "f1.micro" 
#metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Hello from Terraform on Google Cloud!</h1></body></html>' | sudo tee /var/www/html/index.html"
metadata_startup_script = "scripts/bootstrap.sh"

ssh_user = "agustin"
ssh_pub_key_file = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDoCv3AfyXOcxdLTur37gskLwpUMYibr+T2cPgNrbT0xtLXC3vTeXpYH19zrLuOMt3/AaLlY9OX1ikRg6NVmeV4/Oi8dpcy1OIToeeRkM765uy4xIuMpBAqAlqrAl6VS0eKGIqX8TzumTmVkTWJnAN/OXh4VVrbt/yumcJxzn7PKlAhLPXs+VD74fk2bvN+75T/tvQUZ9fYLelC1f2Hjjb/tMM/guoByJwk5VuwsjhTVpLr/d8sQL09t0uKuzmrkwwVPTZp2XrYSZbe1faPNCyiUXLBpT9k9mhySXvq2oXgcF9AGYplWHj+dwp05sGH7Domn+UPBDJAyBHGM85Z6n15 agustin@A796LSL"
