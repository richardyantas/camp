variable "var"{
    environment = "dev"
    gcp_vpc_name = "vpc-ideasextraordinarias-des"
    gcp_subnet_1 = "subnet-2d651a41ced44247-ideasextraordinarias-des"
    gcp_region = "europe-west1"
    gcp_project_id = "jovial-atlas-375801"
    client = "ideasextraordinarias"
    gcp_vpc_cidr = "172.31.0.0/16"
    gcp_zone = "europe-west3"
    zones = ["europe-west3a","europe-west3b","europe-west3c"]

    # vm - BASTION ---------------------------
    cidr_blocks = "0.0.0.0/0"
    machine_type = "f1.micro" 
    #metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Hello from Terraform on Google Cloud!</h1></body></html>' | sudo tee /var/www/html/index.html"
    metadata_startup_script = "scripts/bootstrap.sh"

    # ssh_user = "agustin"
    # ssh_pub_key_file = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDoCv3AfyXOcxdLTur37gskLwpUMYibr+T2cPgNrbT0xtLXC3vTeXpYH19zrLuOMt3/AaLlY9OX1ikRg6NVmeV4/Oi8dpcy1OIToeeRkM765uy4xIuMpBAqAlqrAl6VS0eKGIqX8TzumTmVkTWJnAN/OXh4VVrbt/yumcJxzn7PKlAhLPXs+VD74fk2bvN+75T/tvQUZ9fYLelC1f2Hjjb/tMM/guoByJwk5VuwsjhTVpLr/d8sQL09t0uKuzmrkwwVPTZp2XrYSZbe1faPNCyiUXLBpT9k9mhySXvq2oXgcF9AGYplWHj+dwp05sGH7Domn+UPBDJAyBHGM85Z6n15 agustin@A796LSL"
}


resource "google_compute_address" "static" {
  name = "ip-external-ideasextraordinarias"
}

resource "google_compute_instance" "bastion_instance" {
  name         = "bastion-${var.client}-${var.environment}"
  machine_type = "f1-micro"
  zone         =  "europe-west3-a"  
  tags = [
    "${var.environment}-bastion-http",
    "${var.environment}-bastion-ssh"
     ]
  project      =  var.gcp_project_id
  description   = "${var.client}-${var.environment}-${data.google_compute_subnetwork.subnet-1.ip_cidr_range}"
  network_interface { 
    subnetwork = "${data.google_compute_subnetwork.subnet-1.name}"   
    subnetwork_project = var.gcp_project_id 
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  metadata = {
     # ssh-keys = "${var.ssh_user}:${var.ssh_pub_key_file}"
     # enable-oslogin = "TRUE"  Esto no me funciono aplicand permisos a los usuarios.
      
  }

  metadata_startup_script = file("${var.metadata_startup_script}") # "${var.metadata_startup_script}"
}

resource "google_compute_firewall" "http" {
  name    = "${var.environment}-firewall-http"
  network = "${data.google_compute_network.vpc.name}" # "${google_compute_network.ovirt_network.name}"
  
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  target_tags   = ["${var.environment}-bastion-http"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "ssh" {
  name    = "${var.environment}-firewall-ssh"
  network = "${data.google_compute_network.vpc.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["${var.environment}-bastion-ssh"]
  source_ranges = ["0.0.0.0/0"]
}