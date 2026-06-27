output "cluster_name" {
  description = "GKE Cluster Name"
  value       = google_container_cluster.gke.name
}

output "cluster_endpoint" {
  description = "Kubernetes API Server Endpoint"
  value       = google_container_cluster.gke.endpoint
}

output "network_name" {
  description = "VPC Name"
  value       = google_compute_network.vpc.name
}

output "subnet_name" {
  description = "Subnet Name"
  value       = google_compute_subnetwork.subnet.name
}

output "region" {
  description = "Deployment Region"
  value       = var.region
}