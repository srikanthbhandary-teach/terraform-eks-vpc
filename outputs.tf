output "private_subnet_ids"{    
    value = [for index,  az in local.availability_zones: aws_subnet.private_subnet[index].id]
}

output "public_subnet_ids"{
    value = [for index,  az in local.availability_zones: aws_subnet.public_subnet[index].id]
}

output "vpc_id"{
    value = aws_vpc.cluster_vpc.cidr_block
}

output "vpc_default_security_group_id"{
    value = aws_vpc.cluster_vpc.default_security_group_id
}