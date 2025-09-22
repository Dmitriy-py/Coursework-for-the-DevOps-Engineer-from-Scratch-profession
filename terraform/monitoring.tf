# ВМ для Prometheus
resource "yandex_compute_instance" "prometheus_vm" {
  name        = "prometheus-vm"
  zone        = "ru-central1-a"
  platform_id = "standard-v1"
  hostname    = "prometheus-vm"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8l04iucc4vsh00rkb1"
      size     = 40
    }
  }

  network_interface {
    subnet_id         = yandex_vpc_subnet.private_subnet_a.id
    security_group_ids = [yandex_vpc_security_group.prometheus_sg.id]
    nat               = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}


# Security Group для Grafana (ЗАКОММЕНТИРОВАНО)
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
     v4_cidr_blocks = ["0.0.0.0/0"] # Замените на публичный IP вашей локальной машины (или 0.0.0.0/0 временно)
     description    = "Allow Grafana UI access from your local machine"
   }
   egress {
     protocol        = "any"
     v4_cidr_blocks  = ["0.0.0.0/0"]
     description     = "Allow all outbound traffic for updates, DNS, etc."
   }
 }

 # ВМ для Grafana (ЗАКОММЕНТИРОВАНО)
 resource "yandex_compute_instance" "grafana_vm" {
   name        = "grafana-vm"
   zone        = "ru-central1-b"
   platform_id = "standard-v1"
   hostname    = "grafana-vm"
   resources {
     cores  = 2
     memory = 4
   }
   boot_disk {
     initialize_params {
       image_id = "fd8l04iucc4vsh00rkb1"
       size     = 40
     }
   }
   network_interface {
     subnet_id         = yandex_vpc_subnet.public_subnet.id
     security_group_ids = [yandex_vpc_security_group.grafana_sg.id]
     nat               = true
   }
   metadata = {
     ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
   }
 }

