output cluster_oidc_issuer {
  value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

output cluster_endpoint {
  value = aws_eks_cluster.eks_cluster.endpoint
}