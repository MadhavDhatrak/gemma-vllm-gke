# Gemma 4 on GKE with vLLM

Deployed Google's Gemma 4 language model on Google Kubernetes Engine using vLLM with GPU-based nodes, fully automated with Terraform and Helm via GitHub Actions.

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Testing the Model](#testing-the-model)
- [Model Responses](#model-responses)
- [Destroy Infrastructure](#destroy-infrastructure)
- [Screenshots](#screenshots)

---

## Overview

| | |
|---|---|
| **Model** | google/gemma-4-E2B |
| **Inference Engine** | vLLM |
| **Infrastructure** | GKE with NVIDIA GPU node pool |
| **IaC** | Terraform |
| **Deployment** | Helm |
| **CI/CD** | GitHub Actions |
| **State Storage** | GCS Bucket (tfstate-vaani) |

---

## Architecture

> 📌 Architecture diagram 
<img width="1536" height="1024" alt="ChatGPT Image Jun 27, 2026, 05_48_05 PM" src="https://github.com/user-attachments/assets/bffc06c4-abf7-45f7-a7c9-7f6e8c4777d4" />

---

## Project Structure

```
.
├── .github/
│   └── workflows/
│       ├── deploy.yml        # triggers on push to main
│       └── destroy.yml       # manual trigger only
│
├── terraform/
│   ├── backend.tf            # GCS remote state
│   ├── main.tf               # GKE cluster + GPU node pool
│   ├── variables.tf
│   └── outputs.tf
│
└── gemma-vllm/               # Helm chart
    ├── Chart.yaml
    ├── values.yaml
    └── templates/
        ├── deployment.yaml   # Pod, probes, GPU resources
        ├── service.yaml
        └── secret.yaml       # HuggingFace token
```

---

## Testing the Model

**Port forward the service:**
```bash
kubectl port-forward svc/gemma-vllm 8080:80
```

**Health check:**
```bash
curl http://localhost:8080/health
```

**Run inference:**
```bash
curl http://localhost:8080/v1/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "google/gemma-4-E2B",
    "prompt": "Explain what is Kubernetes in simple words:",
    "max_tokens": 150,
    "temperature": 0.7
  }'
```

---

## Model Responses

**Prompt:** `Explain what is Kubernetes in 3 simple sentences:`

```
Kubernetes is an open source platform that helps you deploy, manage, and scale 
your containerized applications. It provides a way to automate the deployment, 
scaling, and management of containerized applications. Kubernetes is a container 
orchestration platform, which means it helps you manage containers running in 
different environments.
```


---

## Destroy Infrastructure

Go to **Actions** → **Destroy Infrastructure** → **Run workflow** → type `destroy` to confirm.

This will:
1. Remove the Helm release from the cluster
2. Run `terraform destroy` to delete all GCP resources
3. Update the state file in the GCS bucket

---

## Screenshots

### 1.Pods Running
<img width="1462" height="582" alt="image" src="https://github.com/user-attachments/assets/765f1762-ba73-47a7-ab63-a8d4c764b2e2" />

### 2.Nodes Running
<img width="1018" height="122" alt="image" src="https://github.com/user-attachments/assets/e4d6a555-1af0-4227-90a5-d1bff48d7f17" />


### 3. GPU Check
<img width="1133" height="156" alt="image" src="https://github.com/user-attachments/assets/8e367bc3-9c35-41a7-af57-39c587b7f69d" />


### 4. Model Response
<img width="1900" height="373" alt="image" src="https://github.com/user-attachments/assets/d38d06e8-5969-4694-8372-fa80fc910b13" />

