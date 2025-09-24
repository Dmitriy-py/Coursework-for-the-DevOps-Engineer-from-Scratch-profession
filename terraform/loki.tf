resource "yandex_compute_instance" "loki_vm" {
  name               = "loki-vm"
  zone               = "ru-central1-b"
  platform_id        = "standard-v1"
  hostname           = "loki-vm"
  allow_stopping_for_update = true

  resources {
    cores  = 8
    memory = 32
  }

  boot_disk {
    initialize_params {
      image_id = "fd8l04iucc4vsh00rkb1"
      size     = 300
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private_subnet_b.id
    security_group_ids = [yandex_vpc_security_group.loki_sg.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}
