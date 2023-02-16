resource "aws_ecr_repository" "all_repos" {
    for_each = toset(var.ecr_names)

    name = "${var.ecr_prefix}/${each.key}"
    image_tag_mutability = "MUTABLE"

    force_delete = true

    image_scanning_configuration {
      scan_on_push = true
    }
}



