#!/bin/bash

# Scenario 1: Pod stuck in Pending due to impossible Resource Requests
# This mimics a common issue where a pod requests more resources than any node can provide.

set -e

NAMESPACE="troubleshoot-eval"
POD_NAME="pending-heavy-pod"

echo "Creating namespace: $NAMESPACE..."
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

echo "Deploying pod with impossible memory request (1000Gi)..."
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: $POD_NAME
  namespace: $NAMESPACE
  labels:
    app: eval-pending
spec:
  containers:
  - name: heavy-container
    image: busybox
    command: ["sleep", "3600"]
    resources:
      requests:
        memory: "1000Gi"
        cpu: "100"
EOF

echo "------------------------------------------------"
echo "Scenario created: Pod '$POD_NAME' in namespace '$NAMESPACE' should now be stuck in Pending."
echo "Gemini Instructions: Use the k8s-troubleshooter skill to diagnose why this pod is pending."
echo "------------------------------------------------"
