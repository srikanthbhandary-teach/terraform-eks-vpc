# Create public subnets in each availability zone
# Reference : https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html#:~:text=kubernetes.io/role/elb
resource "aws_subnet" "public_subnet" {
  for_each          = { for idx, az in local.availability_zones : idx => az }
  vpc_id            = aws_vpc.cluster_vpc.id
  cidr_block        = var.subnet_public_cidr_blocks[each.key]
  availability_zone = each.value
  tags = merge(
    local.tags,
    {
      "Name" : "${var.cluster_name}-subnet-public-${each.value}",
      "kubernetes.io/role/elb" = "1"
    }
  )
}



# Attach internet gateway to VPC - Not required
# resource "aws_internet_gateway_attachment" "igw_attachment" {
#   vpc_id              = aws_vpc.cluster_vpc.id
#   internet_gateway_id = aws_internet_gateway.igw.id
# }

# Create route table for public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.cluster_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    local.tags,
    {
      "Name" : "${var.cluster_name}-route-table-public"
    }
  )
}

# Associate public subnet with route table
resource "aws_route_table_association" "public_subnet_association" {
  for_each       = { for idx, az in local.availability_zones : idx => az }
  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public_route_table.id
}
