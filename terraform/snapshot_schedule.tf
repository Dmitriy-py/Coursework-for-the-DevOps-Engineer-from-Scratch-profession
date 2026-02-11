resource "yandex_compute_snapshot_schedule" "daily_vm_snapshots" {
  name        = "daily-vm-snapshots"
  folder_id   = "b1gmmll0272r5rs75acl"
  disk_ids = [
    yandex_compute_instance.bastion.boot_disk.0.disk_id,
    yandex_compute_instance.web_server_a.boot_disk.0.disk_id,
    yandex_compute_instance.web_server_b.boot_disk.0.disk_id,
    yandex_compute_instance.grafana_vm.boot_disk.0.disk_id,
    yandex_compute_instance.loki_vm.boot_disk.0.disk_id,
    yandex_compute_instance.prometheus_vm.boot_disk.0.disk_id,
  ]

  schedule_policy {
    expression = "0 0 * * *"
  }

  retention_period = "168h"

  labels = {
    env = "production"
    backup = "daily"
  }
}
