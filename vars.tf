variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

# Define a list of availability zones
variable "availability_zones" {
  type    = list(string)
  default = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
 validation {
    condition     = length(var.availability_zones) == 3
    error_message = "availability_zones must have a minimum length of 3"
  }
}

variable "subnet_private_cidr_blocks" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  validation {
    condition     = length(var.subnet_private_cidr_blocks) == 3
    error_message = "subnet_private_cidr_blocks must have a minimum length of 3"
  }
}

variable "subnet_public_cidr_blocks" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  validation {
    condition     = length(var.subnet_public_cidr_blocks) == 3
    error_message = "subnet_public_cidr_blocks must have a minimum length of 3"
  }
}

variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
  default     = "test_cluster"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add into all resources"
  default     = {}
}

variable "environment" {
  type    = string
  default = "test"
}

var "region"{
  type    = string
  default = "eu-north=1"
}
