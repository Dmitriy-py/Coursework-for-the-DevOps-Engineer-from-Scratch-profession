resource "yandex_vpc_security_group" "bastion_sg" {
  name        = "bastion-sg"
  network_id  = yandex_vpc_network.network.id

  ingress {
    protocol    = "tcp"
    port        = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    port        = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "icmp"
    from_port   = 0
    to_port     = 0
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "web_sg" {
  name        = "web-sg"
  network_id  = yandex_vpc_network.network.id

  # Входящий HTTP/HTTPS с Load Balancer
  ingress {
    protocol        = "tcp"
    port            = 80
    security_group_id = yandex_vpc_security_group.alb_sg.id
  }
  ingress {
    protocol        = "tcp"
    port            = 443
    security_group_id = yandex_vpc_security_group.alb_sg.id
  }

  # Входящий SSH с Bastion
  ingress {
    protocol    = "tcp"
    port        = 22
    security_group_id = yandex_vpc_security_group.bastion_sg.id
  }
  # Входящий ICMP с Bastion (для ping)
  ingress {
    protocol    = "icmp"
    from_port   = 0
    to_port     = 0
    security_group_id = yandex_vpc_security_group.bastion_sg.id
  }

  ingress {
      protocol        = "tcp"
      port            = 9100
      v4_cidr_blocks  = [yandex_vpc_subnet.private_subnet_a.v4_cidr_blocks[0]]
      description     = "Allow Node Exporter metrics from Prometheus"
  }
  # Входящий трафик для Nginx Exporter (порт 9113) от Prometheus
  ingress {
      protocol        = "tcp"
      port            = 9113
      v4_cidr_blocks  = [yandex_vpc_subnet.private_subnet_a.v4_cidr_blocks[0]]
      description     = "Allow Nginx Exporter metrics from Prometheus"
  }

  egress {
    protocol       = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "tcp"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Allow outbound HTTP traffic for apt/web-access"
  }
  egress {
    protocol       = "tcp"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Allow outbound HTTPS traffic for apt/web-access"
  }

egress {
    protocol        = "tcp"
    port            = 3100
    # Используем CIDR-блок подсети, где находится Loki VM
    v4_cidr_blocks  = [yandex_vpc_subnet.private_subnet_b.v4_cidr_blocks[0]]
    description     = "Allow outbound to Loki (Promtail pushing logs)"
  }
}

resource "yandex_vpc_security_group" "alb_sg" {
  name        = "alb-sg"
  network_id  = yandex_vpc_network.network.id

  ingress {
    protocol       = "tcp"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "tcp"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
       protocol       = "icmp"
       from_port      = 0
       to_port        = 0
       v4_cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    protocol          = "any"
    predefined_target = "loadbalancer_healthchecks"
  }

  # Исходящий трафик к веб-серверам
  egress {
    protocol       = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "prometheus_sg" {
  name        = "prometheus-sg"
  network_id  = yandex_vpc_network.network.id

  # Входящий SSH от Bastion
  ingress {
    protocol        = "tcp"
    port            = 22
    security_group_id = yandex_vpc_security_group.bastion_sg.id
    description     = "Allow SSH from Bastion"
  }

  ingress {
    protocol       = "tcp"
    port           = 9090
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Allow Prometheus UI access (from your local machine via Bastion tunnel)"
  }

  egress {
    protocol        = "tcp"
    port            = 9100
    v4_cidr_blocks = [
      yandex_vpc_subnet.private_subnet_a.v4_cidr_blocks[0],
      yandex_vpc_subnet.private_subnet_b.v4_cidr_blocks[0]
    ]
    description     = "Allow outbound to Node Exporter on Web Servers subnets"
  }
  egress {
    protocol        = "tcp"
    port            = 9113
    v4_cidr_blocks = [
      yandex_vpc_subnet.private_subnet_a.v4_cidr_blocks[0],
      yandex_vpc_subnet.private_subnet_b.v4_cidr_blocks[0]
    ]
    description     = "Allow outbound to Nginx Exporter on Web Servers subnets"
  }

  egress {
    protocol        = "any"
    v4_cidr_blocks  = ["0.0.0.0/0"]
    description     = "Allow all outbound traffic for updates, DNS, etc."
  }
}

 resource "yandex_vpc_security_group" "grafana_sg" {
   name        = "grafana-sg"
   network_id  = yandex_vpc_network.network.id
   ingress {
     protocol        = "tcp"
     port            = 22
     security_group_id = yandex_vpc_security_group.bastion_sg.id
     description     = "Allow SSH from Bastion"
   }
   ingress {
     protocol       = "tcp"
     port           = 3000
     v4_cidr_blocks = ["0.0.0.0/0"]
     description    = "Allow Grafana UI access from your local machine"
   }
   egress {
     protocol        = "any"
     v4_cidr_blocks  = ["0.0.0.0/0"]
     description     = "Allow all outbound traffic for updates, DNS, etc."
   }
 }
resource "yandex_vpc_security_group" "loki_sg" {
  name        = "loki-sg"
  network_id  = yandex_vpc_network.network.id

  # SSH доступ с Bastion
  ingress {
    protocol          = "tcp"
    port              = 22
    security_group_id = yandex_vpc_security_group.bastion_sg.id
  }
  # ICMP (ping) с Bastion
  ingress {
    protocol          = "icmp"
    from_port         = 0
    to_port           = 0
    security_group_id = yandex_vpc_security_group.bastion_sg.id
  }
  # Ingress для Loki (порт 3100) от веб-серверов (Promtail)
  ingress {
    protocol       = "tcp"
    port           = 3100
    v4_cidr_blocks = [
      yandex_vpc_subnet.private_subnet_a.v4_cidr_blocks[0],
      yandex_vpc_subnet.private_subnet_b.v4_cidr_blocks[0]
    ]
    description    = "Allow Loki ingestion from Web Servers (Promtail)"
  }
  # Ingress для Loki (порт 3100) от Grafana VM
  ingress {
    protocol          = "tcp"
    port              = 3100
    security_group_id = yandex_vpc_security_group.grafana_sg.id
    description       = "Allow Loki queries from Grafana VM"
  }

  ingress {
    protocol          = "tcp"
    port              = 9080
    security_group_id = yandex_vpc_security_group.prometheus_sg.id
    description       = "Allow Promtail metrics from Prometheus"
  }

  # Egress
  egress {
    protocol       = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Allow all outbound traffic"
  }

    # Egress
  egress {
    protocol       = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Allow all outbound traffic"
  }
}
