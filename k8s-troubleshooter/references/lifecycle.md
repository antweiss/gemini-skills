# Pod Lifecycle Troubleshooting

## Startup Failures

### Image Pull Errors
- **ImagePullBackOff / ErrImagePull**: 
  - Typo in name/tag.
  - Private registry auth missing (`imagePullSecret`).
  - Docker Hub rate limits.
- **Check**: `kubectl describe pod`.

### Pod Stuck in Pending
- **Resource Limits**: Insufficient CPU/Memory on nodes.
- **Taints & Tolerations**: `kubectl describe nodes`. Check if pod tolerates node taints.
- **Affinity**: Pod requirements (nodeSelector/Affinity) not met by any node.

### ContainerCreating
- **CNI Issues**: Running out of IP addresses.
- **Missing Dependencies**: Referenced ConfigMap or Secret does not exist.
- **Mount Failures**: Volume cannot be attached/mounted.

## Runtime Failures

### CrashLoopBackOff
Check exit codes in `kubectl describe pod`:
- **0**: Success (but container exited; check restart policy).
- **1 / 255**: Application error (check logs).
- **137**: OOMKill (Memory limit exceeded).
- **143**: SIGTERM (Graceful shutdown, update, or eviction).

### Zombies & Signals
- **PID 1**: If the app is PID 1 and doesn't handle signals, it won't shut down gracefully (`Terminating` state). 
- **Zombies**: Child processes not cleaned up by PID 1 consume PIDs, causing node instability.
- **Fix**: Use an init process like `tini`.
