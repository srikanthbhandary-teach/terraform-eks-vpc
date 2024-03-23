# Create private subnets in each availability zone
# Reference :  https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html#:~:text=kubernetes.io/role/internal%2Delb
resource "aws_subnet" "private_subnet" {
  for_each          = { for idx, az in local.availability_zones : idx => az }
  vpc_id            = aws_vpc.cluster_vpc.id
  cidr_block        = var.subnet_private_cidr_blocks[each.key]
  availability_zone = each.value

  tags = merge(
    local.tags,
    {
      "Name" : "${var.cluster_name}-subnet-private-${each.value}",
      "kubernetes.io/role/internal-elb" : "1",
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    }
  )
}

# Allocate Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = merge(
    local.tags,
    {
      "Name" : "${var.cluster_name}-eip-nat-gateway"
    }
  )
}

# Create NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id # Can be randomly selected
  tags = merge(
    local.tags,
    {
      "Name" : "${var.cluster_name}-nat-gateway"
    }
  )
}

# Create route table for private subnet
# Improvements:  Multiple route table can be added
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.cluster_vpc.id
  tags = merge(
    local.tags,
    {
      "Name" : "${var.cluster_name}-route-table-private"
    }
  )
}

# Route traffic from private subnet to NAT Gateway
resource "aws_route" "private_route_to_nat" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

# Associate private subnet with route table
resource "aws_route_table_association" "private_subnet_association" {
  for_each       = { for idx, az in local.availability_zones : idx => az }
  subnet_id      = aws_subnet.private_subnet[each.key].id
  route_table_id = aws_route_table.private_route_table.id
}
