resource "yandex_compute_instance" "web_server_a" {
  name        = "web-server-a"
  zone        = "ru-central1-a" # Проверьте зону, если она должна быть ru-central1-b
  platform_id = "standard-v1"
  hostname    = "web-server-a"

  resources {
    cores  = 2
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd8l04iucc4vsh00rkb1" # ID образа Ubuntu Linux
      size  = 20
    }
  }

  network_interface {
    subnet_id         = yandex_vpc_subnet.private_subnet_a.id
    security_group_ids = [yandex_vpc_security_group.web_sg.id]
    nat               = false # Нет публичного IP
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}" # Ваш публичный SSH-ключ
  }
}

resource "yandex_compute_instance" "web_server_b" {
  name        = "web-server-b"
  zone        = "ru-central1-b"
  platform_id = "standard-v1"
  hostname    = "web-server-b"

  resources {
    cores  = 2
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd8l04iucc4vsh00rkb1" # ID образа Ubuntu Linux
      size  = 20
    }
  }

  network_interface {
    subnet_id         = yandex_vpc_subnet.private_subnet_b.id
    security_group_ids = [yandex_vpc_security_group.web_sg.id]
    nat               = false # Нет публичного IP
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}" # Ваш публичный SSH-ключ
  }
}
