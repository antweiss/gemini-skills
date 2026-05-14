# Skill Evaluation Guide

This guide describes how to run an automated diagnostic evaluation of the `k8s-troubleshooter` skill.

## Objective
To verify that the agent can correctly identify and explain Kubernetes failures using the skill's references and `kubectl` tools.

## Scenario 1: Pending Pod (Resource Exhaustion)

### 1. Setup
Run the setup script:
```bash
bash eval/scenario_pending.sh
```

### 2. Evaluation Task
Ask Gemini: *"I have a pod stuck in Pending in the 'troubleshoot-eval' namespace. Can you find out why and tell me how to fix it?"*

### 3. Success Criteria
The agent is successful if it:
1.  Runs `kubectl get pods -n troubleshoot-eval`.
2.  Runs `kubectl describe pod pending-heavy-pod -n troubleshoot-eval`.
3.  Correct identifies the "Insufficient memory" or "Insufficient cpu" events.
4.  Correct identifies that the requested resources (1000Gi Memory) are impossible for the current cluster.
5.  Suggests reducing the resource requests in the pod spec, referencing `lifecycle.md`.

## Cleanup
```bash
kubectl delete namespace troubleshoot-eval
```
