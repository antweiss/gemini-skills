---
name: k8s-troubleshooter
description: Troubleshooting Kubernetes pods and services using kubectl, stern, and k9s. Use when a user reports issues with Kubernetes workloads, needs to check logs, status, events, or deep-dive into networking, storage, and security issues. Automatically installs tools if missing.
---

# K8s Troubleshooter

This skill provides expert-level Kubernetes diagnostic capabilities, leveraging advanced tools and established troubleshooting patterns.

## Quick Start

1. **Verify Environment**: Run `scripts/install_tools.sh` to ensure `kubectl`, `stern`, and `k9s` are available.
2. **Find the Signal**: Use `kubectl get pods -A` and `kubectl get events -A --sort-by='.lastTimestamp'`.
3. **Analyze**: Refer to the specialized reference guides below for in-depth diagnostics.

## Workflow Decision Tree

### 1. Pod won't start?
Check status in `kubectl get pods`:
- **ImagePullBackOff / ErrImagePull**: See [lifecycle.md](references/lifecycle.md#image-pull-errors).
- **Pending**: See [lifecycle.md](references/lifecycle.md#pod-stuck-in-pending) (check resources, taints, affinity).
- **ContainerCreating**: See [lifecycle.md](references/lifecycle.md#containercreating) (check CNI, Volumes, Secrets).

### 2. Pod keeps crashing?
Check exit codes in `kubectl describe pod`:
- **Exit Code 137 (OOMKill)**: Increase memory limits.
- **Exit Code 1 / 255**: Check application logs (use `stern` for easier tailing).
- **CrashLoopBackOff**: See [lifecycle.md](references/lifecycle.md#crashloopbackoff).

### 3. Connectivity issues?
- **DNS timeouts / slow resolution**: See [networking.md](references/networking.md#service-discovery--dns) (check ndots and CoreDNS).
- **Service unreachable**: See [networking.md](references/networking.md#service-troubleshooting) (check selectors and endpoints).
- **Ingress 502/503**: See [networking.md](references/networking.md#ingress--gateway-api).

### 4. Storage problems?
- **PVC Pending**: See [storage.md](references/storage.md#pvc-failures).
- **Permission Denied**: See [storage.md](references/storage.md#permission-denied-on-mounted-volumes).

### 5. Permission / Access issues?
- **Forbidden error**: See [security.md](references/security.md#authorization-rbac) (use `kubectl auth can-i`).
- **Admission rejection**: See [security.md](references/security.md#admission-security) (check Pod Security Standards).

## Specialized Diagnostics

- **Networking**: [networking.md](references/networking.md) (DNS, Services, Ingress, Policies).
- **Storage**: [storage.md](references/storage.md) (PVCs, Mounts, Permissions).
- **Security**: [security.md](references/security.md) (RBAC, Capabilities, Profiles).
- **Node & Infrastructure**: [nodes.md](references/nodes.md) (Kubelet, PLEG, CNI, Kube-Proxy).
- **Pod Lifecycle**: [lifecycle.md](references/lifecycle.md) (Startup, Runtime, Exit Codes).
- **Quick Command Ref**: [troubleshooting.md](references/troubleshooting.md).

## Resources

- **scripts/install_tools.sh**: Automated installer for kubectl, stern, and k9s.
- **references/**: Detailed troubleshooting guides for different K8s domains.
