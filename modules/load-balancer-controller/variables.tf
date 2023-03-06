variable cluster_oidc_issuer {
  type = string
  description = "The identity of the oidc issuer from the eks module"
}

variable cluster_endpoint {
  type = string
  description = "The endpoint of the cluster from the eks module."
}