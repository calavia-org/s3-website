#!/bin/sh

DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends apt-utils dialog dnsutils httpie wget unzip curl jq
DEBIAN_FRONTEND=dialog

LATEST_URL=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | egrep -v 'rc|beta|alpha' | egrep 'linux.*amd64'  | tail -1)
curl ${LATEST_URL} > /tmp/terraform.zip

cd /usr/local/bin && sudo unzip /tmp/terraform.zip
echo "Installed: `/usr/local/bin/terraform version`"

pip install --upgrade pip
pip install pre-commit checkov


curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
go install github.com/aquasecurity/tfsec/cmd/tfsec@latest

pre-commit install
