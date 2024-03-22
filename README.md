

### Variables

| Name                           | Description                                    | Type          | Default Value  | Required |
|--------------------------------|------------------------------------------------|---------------|----------------|----------|
| vpc_cidr                       | The CIDR block for the VPC                    | string        | 10.0.0.0/16   | No       |
| availability_zones             | List of availability zones                    | list(string)  | ["eu-north-1a", "eu-north-1b", "eu-north-1c"] | Yes |
| subnet_private_cidr_blocks     | List of CIDR blocks for private subnets       | list(string)  | ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] | Yes |
| subnet_public_cidr_blocks      | List of CIDR blocks for public subnets        | list(string)  | ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"] | Yes |
| cluster_name                   | Name of the cluster                           | string        | test_cluster   | No       |
| tags                           | A map of tags to add into all resources       | map(string)   | {}             | No       |
| environment                    | Environment name                               | string        | test           | No       |

### Variables

| Name                           | Description                                    | Type          | Default Value  | Required |
|--------------------------------|------------------------------------------------|---------------|----------------|----------|
| vpc_cidr                       | The CIDR block for the VPC                    | string        | 10.0.0.0/16   | No       |
| availability_zones             | List of availability zones                    | list(string)  | ["eu-north-1a", "eu-north-1b", "eu-north-1c"] | Yes |
| subnet_private_cidr_blocks     | List of CIDR blocks for private subnets       | list(string)  | ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] | Yes |
| subnet_public_cidr_blocks      | List of CIDR blocks for public subnets        | list(string)  | ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"] | Yes |
| cluster_name                   | Name of the cluster                           | string        | test_cluster   | No       |
| tags                           | A map of tags to add into all resources       | map(string)   | {}             | No       |
| environment                    | Environment name                               | string        | test           | No       |
