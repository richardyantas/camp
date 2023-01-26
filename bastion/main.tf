

variable "environment"{
    default = "dev"
}

variable "gcp_vpc_name"{
    default = "vpc-ideasextraordinarias-des"
}

variable "gcp_subnet_1" {
    default = "subnet-2d651a41ced44247-ideasextraordinarias-des"
}

variable "gcp_region" {
    default = "europe-west1"
}

variable "gcp_project_id" {
    default = "jovial-atlas-375801"
}

variable "client" {
    default = "ideasextraordinarias"
}

variable "gcp_vpc_cidr"  {
    default = "172.31.0.0/16"
}

variable "gcp_zone"{
    default = "europe-west3"
}

variable "zones" {
    default = ["europe-west3a","europe-west3b","europe-west3c"]
}

variable "cidr_blocks" {
    default = "0.0.0.0/0"
}

variable "machine_type" {
    default = "f1.micro"
}

variable "metadata_startup_script" {
    default = "scripts/bootstrap.sh"
}


provider "google" {
  project     = var.gcp_project_id
  region      = var.gcp_zone
}

data "google_compute_network" "vpc" {
  # name       = var.gcp_vpc_name #  gcp_vpc_name
  name = "vpc-ideasextraordinarias-des"
  project    = var.gcp_project_id
}

data "google_compute_subnetwork" "subnet-1" {
  # ip_cidr_range = "10.2.0.0/16" # added by richard
  name   = var.gcp_subnet_1  
  region = var.gcp_zone
}

data "google_compute_zones" "available" {
  region = var.gcp_zone  #"europe-west3" 
  status = "UP"
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
  # description   = "${var.client}-${var.environment}-${data.google_compute_subnetwork.subnet-1.ip_cidr_range}"
  description   = "${var.client}-${var.environment}"
  network_interface { 
    subnetwork = "${data.google_compute_subnetwork.subnet-1.name}"   
    subnetwork_project = var.gcp_project_id 
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  boot_disk {
    initialize_params {
      # image = "debian-cloud/debian-9"  after do 
      # gcloud config set project jovial-atlas-375801
      # gcloud compute images list | grep debian
      image = "debian-cloud/debian-10"
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
  # network = "${data.google_compute_network.vpc.name}" # "${google_compute_network.ovirt_network.name}"
  network = "vpc-ideasextraordinarias-des"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  target_tags   = ["${var.environment}-bastion-http"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "ssh" {
  name    = "${var.environment}-firewall-ssh"
  network = "vpc-ideasextraordinarias-des"
  # network = "${data.google_compute_network.vpc.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["${var.environment}-bastion-ssh"]
  source_ranges = ["0.0.0.0/0"]
}