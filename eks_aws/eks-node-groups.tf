#Create IAM role for EKS Node Group
resource "aws_iam_role" "nodes_general" {
  name               = "eks-node-group-general"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSWorkerNodePolicy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKS_CNI_Policy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEC2ContainerRegistryReadOnly
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes_general.name
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group
resource "aws_eks_node_group" "node_general" {
  #https://docs.aws.amazon.com/eks/latest/userguide/managed-node-groups.html
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "nodes-general"
  node_role_arn   = aws_iam_role.nodes_general.arn
  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  #Type of ami to provision to the nodes
  ami_type = "AL2_x86_64"

  #Type of capacity associated with the Node Group. ON_DEMAND or SPOT
  capacity_type = "ON_DEMAND"

  # Disk size in GiB for worker nodes
  disk_size = 20

  # Force version upgrade if existing pods are unable to drain
  force_update_version = false

  # List of instance types associated with the group
  instance_types = ["t3.small"]

  labels = {
    role = "nodes-general"
  }

  # K8s version
  version = "1.24"

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only
  ]
}