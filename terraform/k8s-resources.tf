resource "kubernetes_deployment" "todo_app" {
  metadata {
    name = "todo-app-dp007"
    labels = {
      app = "todo"
    }
  }

  spec {
    replicas = 1
    strategy {
      type = "Recreate"
    }
    
    selector {
      match_labels = {
        app = "todo"
      }
    }

    template {
      metadata {
        labels = {
          app = "todo"
        }
      }

      spec {
        container {
          name  = "todo"
          image = var.todo_image

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "todo_service" {
  metadata {
    name = "todo-service-dp007"
  }

  spec {
    selector = {
      app = "todo"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}