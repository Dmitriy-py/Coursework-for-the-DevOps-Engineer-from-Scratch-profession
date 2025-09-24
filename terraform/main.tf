terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.101.0"
    }
  }
  required_version = ">= 1.0"
}

provider "yandex" {
  cloud_id  = "b1gpe6vnl2rgqimj7eo2"
  folder_id = "b1gmmll0272r5rs75acl"
  service_account_key_file = "/home/vm1/yandex_cloud_infra/key.json"
  zone      = "ru-central1-b"
}
