# docker-bake.hcl

variable "VERSION" {
  default = "3.11"
}

variable "TAG" {
  default = "0.0.1"
}

variable "ARCH" {
  default = "amd64" # Harness stage will override with amd64 or arm64
}

variable "ECR_SLUG" {
  default = "979895001312.dkr.ecr.us-east-1.amazonaws.com/${REPO}"
}

variable "GHCR_SLUG" {
  default = "ghcr.io/ompragash/${REPO}"
}

# Base image
target "image" {
  dockerfile = "Dockerfile"
  context    = "."
  tags = [
    "${ECR_SLUG}:${VERSION}-${TAG}-${ARCH}",
    "${GHCR_SLUG}:${VERSION}-${TAG}-${ARCH}",
    "${ECR_SLUG}:${VERSION}-${ARCH}",
    "${GHCR_SLUG}:${VERSION}-${ARCH}"
  ]
}

# Onbuild variant
target "onbuild" {
  inherits   = ["image"]
  dockerfile = "Dockerfile.onbuild"
  tags = [
    "${ECR_SLUG}:${VERSION}-onbuild-${TAG}-${ARCH}",
    "${GHCR_SLUG}:${VERSION}-onbuild-${TAG}-${ARCH}",
    "${ECR_SLUG}:${VERSION}-onbuild-${ARCH}",
    "${GHCR_SLUG}:${VERSION}-onbuild-${ARCH}"
  ]
}

# Onbuild-poetry variant
target "onbuild-poetry" {
  inherits   = ["image"]
  dockerfile = "Dockerfile.onbuild-poetry"
  tags = [
    "${ECR_SLUG}:${VERSION}-onbuild-poetry-${TAG}-${ARCH}",
    "${GHCR_SLUG}:${VERSION}-onbuild-poetry-${TAG}-${ARCH}",
    "${ECR_SLUG}:${VERSION}-onbuild-poetry-${ARCH}",
    "${GHCR_SLUG}:${VERSION}-onbuild-poetry-${ARCH}"
  ]
}
