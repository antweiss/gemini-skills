# Node Troubleshooting

## Kubelet Issues

### PLEG (Pod Lifecycle Event Generator)
- **Symptoms**: Pods stuck in strange states, status updates missing.
- **Cause**: Container runtime (containerd/CRI-O) is slow or overloaded.
- **Logs**: `journalctl -u kubelet`.

### Eviction Manager
- **Disk Pressure**: `nodefs` (root) or `imagefs` (images) filled up.
- **PID Pressure**: Node ran out of PIDs.
- **Check**: `kubectl describe node`.

## Networking Components

### Kube-Proxy
- **iptables mode**: Simple, but slow updates on busy nodes.
- **IPVS mode**: Fast, scales better.
- **Check**: Service behavior differences across nodes.

### CNI & IP Exhaustion
- **CNI Config**: Check `/etc/cni/net.d/` on nodes.
- **IP Exhaustion**: Pods scheduled but stay in `ContainerCreating` because the subnet ran out of IPs. Subnets must be sized for peak pod count.
