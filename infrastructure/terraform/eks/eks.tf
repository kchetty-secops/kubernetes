module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "nginx-eks-cluster"
  cluster_version = "1.29"

  subnet_ids = [aws_subnet.eks_public_subnet_a.id, aws_subnet.eks_public_subnet_b.id]
  vpc_id     = aws_vpc.eks_vpc.id

  eks_managed_node_groups = {
    default = {
      desired_size = 1
      max_size     = 2
      min_size     = 1

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  cluster_addons = {
    coredns = {
      most_recent       = true
      resolve_conflicts = "overwrite"
      configuration_values = jsonencode({
        replicaCount = 1
      })
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }
}
