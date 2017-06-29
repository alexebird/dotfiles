job "foo" {
  datacenters = ["dev-us-east-1"]
  type = "service"

  group "bar" {
  }

  group "foo" {
    count = 4


    task "foo" {
      driver = "docker"

      config {
        image = "hashicorp/http-echo"
        port_map { http = 5678 }
        args = [
          "-text=hello_world"
        ]
      }

      env {
      }

      service {
        name = "foo"
        port = "http"
        tags = ["rest"]
        check {
          type = "http"
          name = "Foo Healthcheck"
          path = "/"
          interval = "10s"
          timeout = "2s"
          initial_status = "passing"
        }
      }

      resources {
        cpu = 100
        memory = 100
        network {
          mbits = 10
          port "http" {}
        }
      }
    }
  }
}
