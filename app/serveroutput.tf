output "public_instance_ids" {
  value = aws_instance.public[*].id
}

output "private_instance_id" {
  value = aws_instance.private.id
}

output "public_ips" {
  value = aws_instance.public[*].public_ip
}

output "private_ip" {
  value = aws_instance.private.private_ip
}
output "public_instance_ids" {
  value = module.servers.public_instance_ids
}

output "public_ips" {
  value = module.servers.public_ips
}

output "private_instance_id" {
  value = module.servers.private_instance_id
}

output "private_ip" {
  value = module.servers.private_ip
}

