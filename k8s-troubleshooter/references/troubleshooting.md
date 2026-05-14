# Kubernetes Troubleshooting Quick Reference

## Core Toolbox
- **Events**: `kubectl get events -A --sort-by='.lastTimestamp'`
- **Describe**: `kubectl describe <resource> <name> -n <namespace>`
- **Logs**: `kubectl logs <pod-name> -n <namespace>` (use `-f` to stream, `--previous` for crashed pods)
- **Debug Pod**: `kubectl debug -it <pod-name> --image=busybox --target=<container-name>` (attach ephemeral container)
- **Debug Node**: `kubectl debug node/<node-name> -it --image=busybox`

## Advanced Tools (Recommended)
- **stern**: Tail logs from multiple pods/containers matching a pattern.
- **k9s**: Terminal-based UI for real-time cluster navigation.

## Common Diagnostic Flow
1. Find failing pods: `kubectl get pods -A`
2. Check Events: `kubectl get events -n <namespace> --sort-by='.lastTimestamp'`
3. Describe Pod: `kubectl describe pod <pod-name> -n <namespace>`
4. Inspect Logs: `kubectl logs <pod-name> -n <namespace> --previous`
5. Test Connectivity: `kubectl exec -it <pod-name> -n <namespace> -- nslookup <service-name>`
