output "instance_id" {
 value = google_compute_instance.bastion_instance.instance_id
}

output "self_link" {
 value = google_compute_instance.bastion_instance.self_link
}

output "name" {
 value = google_compute_instance.bastion_instance.name
}

output "description" {
 value = google_compute_instance.bastion_instance.description
}

output "networkip" {
 value = google_compute_instance.bastion_instance.network_interface.0.network_ip
}

output "subnetwork" {
 # value = google_compute_instance.bastion_instance.network_interface.0.subnetwork
 value = data.google_compute_subnetwork.subnet_one.name
}

output "subnetwork_name" {
 value = google_compute_instance.bastion_instance.network_interface.0.name
}

output "alias_ip_range" {
 value = google_compute_instance.bastion_instance.network_interface.0.alias_ip_range
}