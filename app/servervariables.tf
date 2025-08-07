variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "private_subnet_id" {
  type        = string
  description = "Private subnet ID"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

variable "key_name" {
  type        = string
  description = "SSH Key Pair name"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

