# syntax=docker/dockerfile:1.7

ARG TERRAFORM_VERSION=1.15.5

FROM hashicorp/terraform:${TERRAFORM_VERSION} AS provider-mirror

ARG CODER_PROVIDER_VERSION=2.18.0
ARG KUBERNETES_PROVIDER_VERSION=2.38.0
ARG PROVIDER_PLATFORM=linux_amd64

WORKDIR /tmp/provider-config

RUN <<EOF
cat > providers.tf <<HCL
terraform {
  required_providers {
    coder = {
      source  = "coder/coder"
      version = "${CODER_PROVIDER_VERSION}"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "${KUBERNETES_PROVIDER_VERSION}"
    }
  }
}
HCL

terraform providers mirror \
  -platform="${PROVIDER_PLATFORM}" \
  /opt/terraform/provider-mirror

cat > /opt/terraform/terraform.rc <<'HCL'
provider_installation {
  filesystem_mirror {
    path = "/opt/terraform/provider-mirror"
    include = [
      "registry.terraform.io/coder/coder",
      "registry.terraform.io/hashicorp/kubernetes",
    ]
  }
}
HCL
EOF

FROM ghcr.io/coder/coder:v2.36.0

COPY --from=provider-mirror --chmod=0444 \
  /opt/terraform/terraform.rc \
  /etc/terraform.rc
COPY --from=provider-mirror \
  /opt/terraform/provider-mirror \
  /opt/terraform/provider-mirror

ENV TF_CLI_CONFIG_FILE=/etc/terraform.rc
