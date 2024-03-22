provider "aws"{
    region = "eu-north-1"
}

locals {
  tags = merge(
    var.tags,
    {
      "kubernetes.io/cluster/${var.cluster_name}" = "shared",
    }
  )
  availability_zones = length(var.availability_zones) == 0 ? slice(data.aws_availability_zones.available_zones,0,3): var.availability_zones
}

# Create VPC
resource "aws_vpc" "cluster_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    local.tags,
    {
      "Name" : "${var.cluster_name}"
  })
}

# Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.cluster_vpc.id
  tags = merge(
    local.tags,
    {
      "Name" : "${var.cluster_name}-internet-gateway"
    }
  )
}