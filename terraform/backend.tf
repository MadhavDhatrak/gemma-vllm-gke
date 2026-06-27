terraform {
  backend "gcs" {
    bucket = "tfstate-vaani"
    prefix = "gemma/state"
  }
}

