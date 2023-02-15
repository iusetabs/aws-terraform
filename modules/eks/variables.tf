variable cluster_name {
    description = "The cluster name."
}

variable cluster_version {
    description = "The cluster version."
}

variable public_subnets {
    description = "Inputs from the VPC module."
    type = list(string)
}

variable private_subnets {
    description = "Inputs from the VPC module."
    type = list(string)
}
