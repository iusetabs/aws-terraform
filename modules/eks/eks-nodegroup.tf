resource "aws_eks_node_group" "worker-node-group" {
    cluster_name  = aws_eks_cluster.eks_cluster.name
    node_group_name = var.node_group_name
    node_role_arn  = aws_iam_role.eks-workernodes.arn
    subnet_ids   = var.public_subnets
    // How to set a priority here? 
    instance_types = var.instance_types
    
    ami_type = var.ami_type
    version = var.cluster_version
    disk_size = 20 // Default value

    scaling_config {
        desired_size = 1
        max_size   = 2
        min_size   = 1
    }

    depends_on = [
        aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    ]

}

