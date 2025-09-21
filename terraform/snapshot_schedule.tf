# Ресурс для расписания создания снимков дисков
resource "yandex_compute_snapshot_schedule" "daily_vm_snapshots" {
  name        = "daily-vm-snapshots"
  folder_id   = "b1gmmll0272r5rs75acl" # Используем переменную folder_id, если она у вас определена
  # Если нет, замените на ID вашей папки: folder_id = "<ВАШ_ID_ПАПКИ>"
  # Список ID дисков всех ВМ, для которых будет создаваться расписание
  # Убедитесь, что здесь перечислены ВСЕ ваши виртуальные машины
  disk_ids = [
    yandex_compute_instance.bastion.boot_disk.0.disk_id,
    yandex_compute_instance.web_server_a.boot_disk.0.disk_id,
    yandex_compute_instance.web_server_b.boot_disk.0.disk_id,
    yandex_compute_instance.grafana_vm.boot_disk.0.disk_id,
    yandex_compute_instance.loki_vm.boot_disk.0.disk_id,
    yandex_compute_instance.prometheus_vm.boot_disk.0.disk_id,
    # Добавьте другие ВМ, если они у вас есть
  ]

  # Политика расписания: ежедневное копирование
  schedule_policy {
    # Cron-выражение для ежедневного запуска в полночь (UTC)
    expression = "0 0 * * *"
  }

  # Политика хранения: снимки хранятся одну неделю (7 дней)
  retention_period = "168h"

  # (Опционально) Задать метки для снимков
  labels = {
    env = "production"
    backup = "daily"
  }
}
