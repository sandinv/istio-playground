variable "cluster_name" {
	type = string
}
variable "extra_port_mapping" {
  type = list(object({
	container_port = number
	host_port = number
	protocol = string
  }))
}
