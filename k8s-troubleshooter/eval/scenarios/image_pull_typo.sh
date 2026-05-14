#!/bin/bash

# Scenario 3: Pod in ImagePullBackOff due to typo in image name
# This checks if the agent identifies the typo.

set -e

NAMESPACE="troubleshoot-eval"
POD_NAME="typo-image-pod"

echo "Creating namespace: $NAMESPACE..."
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

echo "Deploying pod with typo in image name (nginx -> nginxx)..."
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: $POD_NAME
  namespace: $NAMESPACE
  labels:
    app: eval-typo
spec:
  containers:
  - name: web-container
    image: nginxx:latest
EOF

echo "------------------------------------------------"
echo "Scenario created: Pod '$POD_NAME' in namespace '$NAMESPACE' should be in ImagePullBackOff."
echo "Gemini Instructions: Identify the cause of the image pull failure."
echo "------------------------------------------------"
