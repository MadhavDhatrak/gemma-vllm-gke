variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-east1-d"
}

variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "gemma-cluster"
}

variable "network_name" {
  description = "VPC Name"
  type        = string
  default     = "gemma-vpc"
}

variable "subnet_name" {
  description = "Subnet Name"
  type        = string
  default     = "gemma-subnet"
}

variable "machine_type" {
  description = "GPU node machine type"
  type        = string
  default     = "g2-standard-4"
}

variable "gpu_type" {
  description = "GPU type"
  type        = string
  default     = "nvidia-l4"
}