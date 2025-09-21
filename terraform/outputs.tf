output "alb_external_ip_address" {
  description = "The external IPv4 address of the Application Load Balancer"
  value       = yandex_alb_load_balancer.my_alb.listener.0.endpoint.0.address.0.external_ipv4_address
}
