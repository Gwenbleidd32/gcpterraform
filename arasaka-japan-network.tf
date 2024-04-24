resource "google_compute_network" "arasaka-japan" {
  name                    = "arasaka-japan"
  description             = "arasaka-main-hq-network"
  auto_create_subnetworks = false  # Custom subnet mode
  routing_mode            = "REGIONAL"
  mtu                     = 1460
}
output "network2" {
  value = google_compute_network.arasaka-japan.name   
}
/*Subnet-1*/
resource "google_compute_subnetwork" "mikoshi-hq-tokyo" {
  name          = "mikoshi-hq-tokyo"
  description   = "secret mikoshi program"
  ip_cidr_range = "10.132.32.0/24"
  region        = "asia-northeast1"
  network       = google_compute_network.arasaka-japan.id
}
#Essential subnet information
output "network2-sub1" {
  value = google_compute_subnetwork.mikoshi-hq-tokyo.name  
}
output "network2-sub1-range" {
  value = google_compute_subnetwork.mikoshi-hq-tokyo.ip_cidr_range   
}
output "network2-sub1-region" {
  value = google_compute_subnetwork.mikoshi-hq-tokyo.region   
}
/*Subnet-2*/
resource "google_compute_subnetwork" "osaka-dispatch" {
  name          = "osaka-dispatch"
  description   = "osaka working office"
  ip_cidr_range = "10.132.76.0/24"
  region        = "asia-northeast2"
  network       = google_compute_network.arasaka-japan.id
}
#Essential subnet information
output "network2-sub2" {
  value = google_compute_subnetwork.osaka-dispatch.name
}
output "network2-sub2-range" {
  value = google_compute_subnetwork.osaka-dispatch.ip_cidr_range
}
output "network2-sub2-region" {
  value = google_compute_subnetwork.osaka-dispatch.region
}

/* Firewall Rules */

resource "google_compute_firewall" "allow_icmp" {
  name        = "griffin-school-allow-icmp"
  network     = google_compute_network.arasaka-japan.id
  description = "Allows ICMP connections from any source to any instance on the network."
  direction   = "INGRESS"
  priority    = 65534
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "allow_rdp" {
  name        = "griffin-school-allow-rdp"
  network     = google_compute_network.arasaka-japan.id
  description = "Allows RDP connections from any source to any instance on the network using port 3389."
  direction   = "INGRESS"
  priority    = 65534
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
}

resource "google_compute_firewall" "allow_ssh" {
  name        = "griffin-school-allow-ssh"
  network     = google_compute_network.arasaka-japan.id
  description = "Allows TCP connections from any source to any instance on the network using port 22."
  direction   = "INGRESS"
  priority    = 65534
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}