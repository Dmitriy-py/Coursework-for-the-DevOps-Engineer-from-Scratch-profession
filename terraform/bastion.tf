resource "yandex_compute_instance" "bastion" {
  name        = "bastion-host"
  zone        = "ru-central1-b"
  platform_id = "standard-v1"
  hostname    = "bastion-host"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd8l04iucc4vsh00rkb1"
      size  = 30
    }
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.public_subnet.id
    security_group_ids = [yandex_vpc_security_group.bastion_sg.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}

