resource "google_compute_address" "static" {
  name = "ip-external-sc-jenkins-terraform-test2"
}


resource "google_compute_instance" "bastion_instance" {
  name         = "bastion-${var.client}-${var.environment}"
  machine_type = "f1-micro"
  zone         =  "europe-west3-a"
  # zone         =  "europe-west3"  
  # tags = [ "${var.environment}-bastion-http", "${var.environment}-bastion-ssh"]
  project      =  var.gcp_project_id
  # description   = "${var.client}-${var.environment}-${data.google_compute_subnetwork.subnet-1.ip_cidr_range}"
  description   = "${var.client}-${var.environment}"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface { 
    subnetwork = data.google_compute_subnetwork.subnet_one.name    
    subnetwork_project = var.gcp_project_id
    # subnetwork = "vpc-subnet-sc-jenkins-terraform-des"
    # subnetwork_project = "jovial-atlas-375801"
    
    access_config {
      nat_ip = google_compute_address.static.address
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