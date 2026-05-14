# Storage & Persistence Troubleshooting

## PVC Failures

### PVC Stuck in Pending
- **StorageClass Mismatch**: `kubectl describe pvc <name>`. Check if the requested StorageClass exists or is default.
- **WaitForFirstConsumer**: Volume binding is delayed until the pod is scheduled. If the pod is Pending due to resource issues, the PVC will also stay Pending.

### Attach/Detach Errors
- **Multi-Attach**: Common with cloud block storage. A volume is already attached to a crashed node and cannot be moved.
- **Check**: `kubectl describe pod` for `FailedAttachVolume` events.

## Data Access Issues

### reclaimPolicy
- **Delete**: Underlying disk is deleted when PVC is deleted.
- **Retain**: PV and disk are kept for manual cleanup. 
- **Check**: `kubectl get storageclass <name> -o yaml | grep reclaimPolicy`.

### Permission Denied
- **Symptoms**: Pod starts but app crashes with permission errors on mounted volumes.
- **Cause**: Container runs as non-root, but volume is owned by root.
- **Fix**: Use `securityContext.fsGroup` or `securityContext.runAsUser`.
