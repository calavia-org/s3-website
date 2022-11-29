#!/bin/sh
DEBIAN_FRONTEND=noninteractive

sudo apt-get -qq update && sudo apt-get -qq install -y --no-install-recommends \
  gnupg \
  software-properties-common \
  curl \
  jq \
  apt-transport-https \
  ca-certificates

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
curl -fsSL  https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
# Focal repository not yet available
#sudo apt-add-repository "deb [arch=amd64] https://apt.kubernetes.io/ $(lsb_release -cs) main"
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

sudo apt-get -qq update && sudo apt-get -qq install -y --no-install-recommends \
  terraform \
  plantuml

mkdir -p /home/codespace/.terraform.d/
cat << EOF > /home/codespace/.terraform.d/credentials.tfrc.json
{
  "credentials": {
    "app.terraform.io": {
      "token": "$TF_API_TOKEN"
    }
  }
}
EOF

pip install --upgrade pip
pip install pre-commit checkov


curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
go install github.com/aquasecurity/tfsec/cmd/tfsec@latest

cd $CODESPACE_VSCODE_FOLDER && pre-commit install -f
