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
  default = "734046833946.dkr.ecr.ap-southeast-2.amazonaws.com/buildx-push-only"
}

variable "GHCR_SLUG" {
  default = "ghcr.io/ompragash/docker-buildx-bake"
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
