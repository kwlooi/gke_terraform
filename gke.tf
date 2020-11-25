resource "google_container_cluster" "my_cool_cluster" {
  name               = "my-cool-cluster"
  location           = "us-central1-f"
  initial_node_count = 3
  provider           = google-beta

  network    = "default"
  subnetwork = "default"

  vertical_pod_autoscaling {
    enabled = true
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/16"
    services_ipv4_cidr_block = "/22"
  }

  node_config {
    machine_type = "e2-standard-4"
  }

  addons_config {
    cloudrun_config {
      disabled = false
    }
    istio_config {
      disabled = false
    }
  }
}

resource "null_resource" "custom_domain" {
  depends_on = [
    google_container_cluster.my_cool_cluster
  ]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "/bin/bash custom-domain.sh"
  }
}