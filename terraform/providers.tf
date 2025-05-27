provider "aws" {
  region = "eu-central-1"
}

data "aws_eks_cluster" "cluster" {
  name = "eksDeepDiveFrankfurt"
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.aws_eks_cluster.cluster.name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

terraform {
  backend "s3" {
    bucket         = "terraform-albgm-fvm-eu"
    key            = "state/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock-table"
  }
}