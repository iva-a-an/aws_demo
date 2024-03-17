variable "env" {
  type = string
}

variable "region" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "ip_whitelist" {
  type = list(string)
}

variable "admin_ssh_public_key" {
  type = string  
}