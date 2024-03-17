module "ec2" {
  source = "../../../modules/ec2"
  env = var.env
  tags = var.tags
  ip_whitelist = var.ip_whitelist
  region = var.region
  admin_ssh_public_key = var.admin_ssh_public_key
}