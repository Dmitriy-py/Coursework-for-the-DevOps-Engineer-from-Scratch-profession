resource "yandex_alb_load_balancer" "my_alb" {
  name        = "my-alb"
  network_id  = yandex_vpc_network.network.id
  
  allocation_policy {
    location {
      zone_id   = "ru-central1-b" # Используйте zone_id
      subnet_id = yandex_vpc_subnet.public_subnet.id
    }
  }

  listener {
    name = "http-listener"
    # ИСПРАВЛЕНО: endpoint теперь имеет 'address' и 'ports'
    endpoint {
      address {
        external_ipv4_address {} # Слушаем на внешнем IPv4 адресе
      }
      ports = [80] # Слушаем на порту 80
    }
    http { # Этот блок определяет протокол как HTTP
      handler {
        http_router_id = yandex_alb_http_router.my_http_router.id
      }
    }
  }

  security_group_ids = [yandex_vpc_security_group.alb_sg.id]
}

resource "yandex_alb_http_router" "my_http_router" {
  name = "my-http-router"
  # network_id УДАЛЕН отсюда
}

resource "yandex_alb_virtual_host" "my_virtual_host" {
  name            = "my-virtual-host"
  http_router_id  = yandex_alb_http_router.my_http_router.id
  route {
    name = "my-route"
    http_route {
      # ИСПРАВЛЕНО: http_route_action напрямую внутри http_route
      http_route_action {
        backend_group_id = yandex_alb_backend_group.my_backend_group.id
      }
      # match {
      #   path {
      #     prefix = "/"
      #   }
      # }
    }
  }
}

resource "yandex_alb_backend_group" "my_backend_group" {
  name = "my-backend-group"
  session_affinity {
    connection {
      source_ip = true
    }
  }
  http_backend {
    name                = "backend-web-servers"
    port                = 80
    target_group_ids    = [yandex_alb_target_group.web_servers_target_group.id]
    healthcheck {
      timeout             = "1s"
      interval            = "1s"
      unhealthy_threshold = 2
      healthy_threshold   = 5
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_target_group" "web_servers_target_group" {
  name = "web-servers-target-group"
  target {
    subnet_id  = yandex_vpc_subnet.private_subnet_a.id
    ip_address = yandex_compute_instance.web_server_a.network_interface.0.ip_address
  }
  target {
    subnet_id  = yandex_vpc_subnet.private_subnet_b.id
    ip_address = yandex_compute_instance.web_server_b.network_interface.0.ip_address
  }
}
