variable "vpc_name" {
  type = string
  description = "The name of the VPC"
}

variable cluster_name {
    description = "The cluster name."
}

variable cluster_version {
    description = "The cluster version."
}

variable node_group_name {
    description = "Name of the node group."
    type = string
}

variable instance_types {
    description = "The desired instance types for the node group."
    type = list(string)
}

variable ami_type {
    description = "The identifier of the image that the nodes will use"
    type = string
}

variable instance_http_port {
    description = "The custom port listening to http traffic" 
    type = number
}

variable instance_https_port {
    description = "The custom port listening to https traffic" 
    type = number
}

variable ecr_names {
    description = "A list of names for ecr repositories"
    type = list(string)
}

variable ecr_prefix {
    description = "A common prefix to add to the name of ecr repositories" 
    type = string
}

variable aws_profile {
    description = "The AWS profile to be used."
}