# Networking & Connectivity Troubleshooting

## Service Discovery & DNS

### The `ndots` Problem
Kubernetes sets `ndots:5` by default. Names with fewer than 5 dots are treated as internal, causing multiple internal DNS lookups before trying external servers. This adds latency to outbound requests.
- **Check**: `cat /etc/resolv.conf` in the pod.

### Debugging CoreDNS
- **Logs**: `kubectl logs -n kube-system -l k8s-app=kube-dns`
- **Common Errors**:
  - `i/o timeout`: Cannot reach upstream DNS.
  - `no such host`: Service doesn't exist or record not created.
- **Scaling**: Check if CoreDNS needs more replicas: `kubectl get deployment coredns -n kube-system`.

### Service Troubleshooting
- **No Endpoints**: `kubectl describe svc <name>`. If `Endpoints: <none>`, the selector doesn't match pod labels.
- **Port Mismatch**: `port` is the service port; `targetPort` is the container port. Ensure `targetPort` matches the application's listening port.

## Traffic Flow

### Ingress & Gateway API
- **502 Bad Gateway**: Ingress cannot reach backend (no endpoints or wrong targetPort).
- **503 Service Unavailable**: No healthy pods (check Readiness probes).
- **Gateway API**: Check conditions: `kubectl describe gateway <name>`. Look for `Accepted: False` or `Programmed: False`.

### Network Policies
NetworkPolicies drop traffic silently. 
- **Symptoms**: Traffic works within a namespace but fails across namespaces.
- **Check**: Verify both ingress and egress rules allow the intended traffic.
