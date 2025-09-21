# Курсовая работа на профессии "DevOps-инженер с нуля"

## ` Дмитрий Климов `

## О проекте
Этот проект демонстрирует развертывание полного стека для сбора, хранения и визуализации логов Nginx в облачной инфраструктуре Yandex Cloud. Используются инструменты IaC (Terraform) и Configuration Management (Ansible) для автоматизации процессов.

## Используемые технологии
*   **Облачная платформа:** Yandex Cloud
*   **Infrastructure as Code (IaC):** Terraform
*   **Configuration Management:** Ansible
*   **Сбор метрик:** Prometheus
*   **Логирование:** Loki, Promtail
*   **Визуализация:** Grafana
*   **Веб-сервер:** Nginx
*   **Контейнеризация:** Docker
*   **Дополнительно:** Bash, Git

## Архитектура

<img width="1920" height="1080" alt="Снимок экрана (1478)" src="https://github.com/user-attachments/assets/dc55bf0f-673f-4d97-8aa6-33d473a2ef7d" />

<img width="1920" height="1080" alt="Снимок экрана (1481)" src="https://github.com/user-attachments/assets/bfcd5f5b-d79b-49ef-8e18-b49bccdfc897" />

<img width="1920" height="1080" alt="Снимок экрана (1480)" src="https://github.com/user-attachments/assets/0cbc60ea-006f-4a71-a68a-de583e9fb0ab" />

<img width="1920" height="1080" alt="Снимок экрана (1484)" src="https://github.com/user-attachments/assets/eb64d033-c8e2-4d03-8c5e-e5022ca8a538" />

<img width="1920" height="1080" alt="Снимок экрана (1485)" src="https://github.com/user-attachments/assets/8284d22f-227e-4b3a-b61a-e779b93bb0a2" />

<img width="1920" height="1080" alt="Снимок экрана (1486)" src="https://github.com/user-attachments/assets/dad9abca-5dd1-4613-a414-31b60d84de92" />

<img width="1920" height="1080" alt="Снимок экрана (1487)" src="https://github.com/user-attachments/assets/365cdd14-b7bc-4390-8fac-1d5301b94695" />

## Развертывание (Deployment): 

### ` Terraform `

<img width="1920" height="1080" alt="Снимок экрана (1482)" src="https://github.com/user-attachments/assets/50ae16ab-652d-4c04-87b2-ca6a4b9fa234" />

### ` ansible-nginx_install.yml `

<img width="1920" height="1080" alt="Снимок экрана (1302)" src="https://github.com/user-attachments/assets/363310e3-bf74-4547-b3aa-c08c9f97f760" />

<img width="1920" height="1080" alt="Снимок экрана (1303)" src="https://github.com/user-attachments/assets/7c86d609-ffb4-4951-aa5e-33dbdf2b64a7" />

<img width="1920" height="1080" alt="Снимок экрана (1304)" src="https://github.com/user-attachments/assets/4753607e-a6bc-4381-8487-ce6e28ebf43f" />

### ` ansible-nginx_install.yml -site_content `

<img width="1920" height="1080" alt="Снимок экрана (1305)" src="https://github.com/user-attachments/assets/c584dc6d-16c4-4988-a186-d663b6c1fe72" />

<img width="1920" height="1080" alt="Снимок экрана (1306)" src="https://github.com/user-attachments/assets/1ca8456b-d7f3-422e-ade9-f6138e7c53e7" />

<img width="1920" height="1080" alt="Снимок экрана (1307)" src="https://github.com/user-attachments/assets/9bfd8e15-ac55-4860-b5ef-7944015c8f75" />

<img width="1920" height="1080" alt="Снимок экрана (1313)" src="https://github.com/user-attachments/assets/19244e45-bf70-4b66-8cc7-c70f95fbb6fc" />

### ` Prometheus `

<img width="1920" height="1080" alt="Снимок экрана (1321)" src="https://github.com/user-attachments/assets/6db92b39-b5ac-489a-ae2f-76b83d9de115" />

### ` Loki `

<img width="1920" height="1080" alt="Снимок экрана (1347)" src="https://github.com/user-attachments/assets/48272031-5bd2-4cf6-8bb8-12955a00d4a5" />

### ` Promtail `

<img width="1920" height="1080" alt="Снимок экрана (1450)" src="https://github.com/user-attachments/assets/c4e42a83-b21b-46d7-bfae-eb7c2e5c3c11" />

<img width="1920" height="1080" alt="Снимок экрана (1451)" src="https://github.com/user-attachments/assets/f505df5b-fc75-4c14-8aac-5dc7014bd88b" />

### ` Grafana `

<img width="1920" height="1080" alt="Снимок экрана (1443)" src="https://github.com/user-attachments/assets/603275b0-feb5-4425-aaa9-7b1a26b77b86" />

<img width="1920" height="1080" alt="Снимок экрана (1343)" src="https://github.com/user-attachments/assets/98e5b93a-64b7-4a2f-b9de-2e683c7b68f2" />

## Работа балансировщика

### ` Grafana--my-alb-load_balancer `

<img width="1920" height="1080" alt="Снимок экрана (1466)" src="https://github.com/user-attachments/assets/673e0895-2efd-4953-8da1-78b583dc1a40" />

<img width="1920" height="1080" alt="Снимок экрана (1467)" src="https://github.com/user-attachments/assets/17a62be0-0575-4e65-9dbb-cc9aeb15eb8c" />

<img width="1920" height="1080" alt="Снимок экрана (1468)" src="https://github.com/user-attachments/assets/7efb7d8b-a0a7-4b85-8f09-90fd51e4558d" />

<img width="1920" height="1080" alt="Снимок экрана (1469)" src="https://github.com/user-attachments/assets/6eb45c19-f658-4481-91ee-6995292e86d8" />

<img width="1920" height="1080" alt="Снимок экрана (1470)" src="https://github.com/user-attachments/assets/04ec8eb6-6367-4aad-a67a-da04437fcd48" />

<img width="1920" height="1080" alt="Снимок экрана (1471)" src="https://github.com/user-attachments/assets/ca8f13bf-f37f-481b-ac83-454bd8bbd068" />

<img width="1920" height="1080" alt="Снимок экрана (1472)" src="https://github.com/user-attachments/assets/64a747d8-355b-4b45-bc1f-503c04289da2" />

## Сбор метрик

### ` Grafana-Prometheus `

<img width="1920" height="1080" alt="Снимок экрана (1457)" src="https://github.com/user-attachments/assets/cda50d56-6f93-492e-83bb-7653facb0245" />

<img width="1920" height="1080" alt="Снимок экрана (1458)" src="https://github.com/user-attachments/assets/54f11ee9-adc4-4c4f-8655-97828be66e52" />

<img width="1920" height="1080" alt="Снимок экрана (1459)" src="https://github.com/user-attachments/assets/1cc7cfea-21d7-4c31-9048-de0f888195e2" />

<img width="1920" height="1080" alt="Снимок экрана (1460)" src="https://github.com/user-attachments/assets/d75f8696-a861-490e-a6c0-1c13ab988aa7" />

<img width="1920" height="1080" alt="Снимок экрана (1461)" src="https://github.com/user-attachments/assets/80932020-8f91-4114-90c1-fe3b1ab5ee88" />

<img width="1920" height="1080" alt="Снимок экрана (1462)" src="https://github.com/user-attachments/assets/e7a10c12-f146-4baf-9e92-aec412c4b9ca" />

<img width="1920" height="1080" alt="Снимок экрана (1463)" src="https://github.com/user-attachments/assets/edafcd43-c850-4706-91bc-4bc66017ccfb" />

<img width="1920" height="1080" alt="Снимок экрана (1464)" src="https://github.com/user-attachments/assets/efd85f8a-f495-45c5-8430-e6959e8c9c4b" />

<img width="1920" height="1080" alt="Снимок экрана (1465)" src="https://github.com/user-attachments/assets/9ff0442e-e2e2-46f5-bd29-5d0cd358ed02" />

## Сбор логов

### ` Grafana-Loki `

<img width="1920" height="1080" alt="Снимок экрана (1454)" src="https://github.com/user-attachments/assets/ad6dd075-c3cc-4930-862c-2a0b15b5f421" />

<img width="1920" height="1080" alt="Снимок экрана (1455)" src="https://github.com/user-attachments/assets/3894d6f3-9afc-4674-bcee-92c2071d718b" />

<img width="1920" height="1080" alt="Снимок экрана (1456)" src="https://github.com/user-attachments/assets/6a7f2480-3a53-4b0d-a702-6c45fe26e865" />

<img width="1920" height="1080" alt="Снимок экрана (1473)" src="https://github.com/user-attachments/assets/b5adf627-3e51-4dbe-a62c-7c421327c599" />


## Резервное копирование

### ` Снимки (Snapshots) `

<img width="1920" height="1080" alt="Снимок экрана (1474)" src="https://github.com/user-attachments/assets/5acb2c9a-2d4c-4584-82fa-581e92c303ae" />

<img width="1920" height="1080" alt="Снимок экрана (1475)" src="https://github.com/user-attachments/assets/9894aaa7-b571-47a2-ac10-121569fb32a5" />

<img width="1920" height="1080" alt="Снимок экрана (1476)" src="https://github.com/user-attachments/assets/e69ef359-86e0-4eb4-983f-9a48f58e4a5c" />

<img width="1920" height="1080" alt="Снимок экрана (1477)" src="https://github.com/user-attachments/assets/5ba69504-e1ea-4f46-baa2-eecfa5ef73e9" />



