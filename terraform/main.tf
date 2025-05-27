data "aws_vpc" "vpc" {
  id = data.aws_eks_cluster.cluster.vpc_config[0].vpc_id
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_security_group" "eks_sg" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "group-name"
    values = ["eks-cluster-sg-eksDeepDiveFrankfurt-1978535350"]
  }
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = data.aws_eks_cluster.cluster.name
  node_group_name = "nodeGroupDp007"
  node_role_arn   = var.node_role_arn
  subnet_ids      = data.aws_subnets.subnets.ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.small"]

  remote_access {
    ec2_ssh_key               = var.ssh_key_name
    source_security_group_ids = [data.aws_security_group.eks_sg.id]
  }

  depends_on = [data.aws_eks_cluster.cluster]
}