#!/bin/bash

# Tool Installer for Kubernetes Troubleshooting
# Installs: kubectl, stern, k9s

set -e

OS=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

install_kubectl() {
    if command -v kubectl &> /dev/null; then
        echo "kubectl is already installed."
        return 0
    fi
    echo "Installing kubectl..."
    if [[ "$OS" == "darwin" ]] && command -v brew &> /dev/null; then
        brew install kubectl
    else
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/${OS}/${ARCH}/kubectl"
        chmod +x ./kubectl
        sudo mv ./kubectl /usr/local/bin/kubectl
    fi
}

install_stern() {
    if command -v stern &> /dev/null; then
        echo "stern is already installed."
        return 0
    fi
    echo "Installing stern..."
    if [[ "$OS" == "darwin" ]] && command -v brew &> /dev/null; then
        brew install stern
    else
        # For Linux, simple way is to use GH releases, but brew is easier if available
        # Defaulting to brew if on Linux and has brew, else manual
        if command -v brew &> /dev/null; then
            brew install stern
        else
            echo "Please install stern manually for your distribution: https://github.com/stern/stern"
        fi
    fi
}

install_k9s() {
    if command -v k9s &> /dev/null; then
        echo "k9s is already installed."
        return 0
    fi
    echo "Installing k9s..."
    if [[ "$OS" == "darwin" ]] && command -v brew &> /dev/null; then
        brew install k9s
    else
        if command -v brew &> /dev/null; then
            brew install derailed/k9s/k9s
        else
            echo "Please install k9s manually for your distribution: https://github.com/derailed/k9s"
        fi
    fi
}

install_kubectl
install_stern
install_k9s

echo "Installation complete."
