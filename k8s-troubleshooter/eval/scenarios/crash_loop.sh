#!/bin/bash

# Scenario 2: Pod in CrashLoopBackOff due to missing Env Var
# The app expects an environment variable to start.

set -e

NAMESPACE="troubleshoot-eval"
POD_NAME="crashing-pod"

echo "Creating namespace: $NAMESPACE..."
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

echo "Deploying pod that crashes if APP_SECRET is missing..."
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: $POD_NAME
  namespace: $NAMESPACE
  labels:
    app: eval-crash
spec:
  containers:
  - name: app-container
    image: busybox
    command: ["sh", "-c", "if [ -z \"\$APP_SECRET\" ]; then echo \"Error: APP_SECRET is missing\"; exit 1; else sleep 3600; fi"]
EOF

echo "------------------------------------------------"
echo "Scenario created: Pod '$POD_NAME' in namespace '$NAMESPACE' should be in CrashLoopBackOff."
echo "Gemini Instructions: Diagnose the crash and identify the missing configuration."
echo "------------------------------------------------"
