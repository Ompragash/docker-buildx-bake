# docker-bake.hcl

variable "VERSION" {
  default = "3.11"
}

variable "TAG" {
  default = "0.0.1"
}

variable "ECR_SLUG" {
  default = "979895001312.dkr.ecr.us-east-1.amazonaws.com/${REPO}"
}

variable "GHCR_SLUG" {
  default = "ghcr.io/boost-insurance/${REPO}"
}

# Base image
target "image" {
  dockerfile = "Dockerfile"
  context    = "."
  tags = [
    "${ECR_SLUG}:${VERSION}-${TAG}",
    "${GHCR_SLUG}:${VERSION}-${TAG}",
    "${ECR_SLUG}:${VERSION}",
    "${GHCR_SLUG}:${VERSION}"
  ]
}

# Onbuild variant
target "onbuild" {
  inherits   = ["image"]
  dockerfile = "Dockerfile.onbuild"
  tags = [
    "${ECR_SLUG}:${VERSION}-onbuild-${TAG}",
    "${GHCR_SLUG}:${VERSION}-onbuild-${TAG}",
    "${ECR_SLUG}:${VERSION}-onbuild",
    "${GHCR_SLUG}:${VERSION}-onbuild"
  ]
}

# Onbuild-poetry variant
target "onbuild-poetry" {
  inherits   = ["image"]
  dockerfile = "Dockerfile.onbuild-poetry"
  tags = [
    "${ECR_SLUG}:${VERSION}-onbuild-poetry-${TAG}",
    "${GHCR_SLUG}:${VERSION}-onbuild-poetry-${TAG}",
    "${ECR_SLUG}:${VERSION}-onbuild-poetry",
    "${GHCR_SLUG}:${VERSION}-onbuild-poetry"
  ]
}
