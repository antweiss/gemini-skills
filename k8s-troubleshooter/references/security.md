# Security & RBAC Troubleshooting

## Authorization (RBAC)

### Access Denied
- **Check Permissions**: `kubectl auth can-i <verb> <resource> --as=system:serviceaccount:<namespace>:<sa-name>`.
- **ServiceAccounts**: Default SAs have almost no permissions. Create dedicated SAs and bind specific Roles/ClusterRoles.
- **RoleBinding vs ClusterRoleBinding**: RoleBinding is namespace-scoped; ClusterRoleBinding is cluster-wide.

## Runtime Security

### SecurityContext
- **Capabilities**: Apps needing low-level access (e.g., `NET_ADMIN`, `SYS_TIME`) will fail with "Operation not permitted" if capabilities are missing.
- **Read-Only Root FS**: Best practice, but app may fail if it tries to write to `/tmp` or logs. Fix by mounting `emptyDir` to writable paths.
- **Non-Root & Ports**: Non-root users cannot bind to ports < 1024. Use higher ports (e.g., 8080) and map them via Service.

## Admission Security

### Pod Security Standards
- **Profiles**: Privileged, Baseline, Restricted.
- **Enforcement**: If a namespace is labeled `pod-security.kubernetes.io/enforce=restricted`, pods requesting root or privileged access will be rejected at admission.
- **Check**: `kubectl get ns <namespace> --show-labels`.
