terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20.0"
    }
  }
  required_version = ">= 1.0"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "dev_deploy" {
  metadata {
    name = "dev-deploy"
    labels = {
      app = "dev"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "dev"
      }
    }
    template {
      metadata {
        labels = {
          app = "dev"
        }
      }
      spec {
        container {
          name  = "dev-container"
          image = "dev:latest"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "dev_service" {
  metadata {
    name = "dev-service"
  }
  spec {
    type = "NodePort"
    selector = {
      app = "dev"
    }
    port {
      port        = 80
      target_port = 80
      node_port   = 30007
    }
  }
}
