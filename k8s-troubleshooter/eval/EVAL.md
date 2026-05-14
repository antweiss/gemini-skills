# Skill Benchmark Guide

This benchmark compares Gemini CLI's performance with and without the `k8s-troubleshooter` skill.

## Benchmark Metrics
| Metric | Description |
| :--- | :--- |
| **Success Rate** | Was the root cause correctly identified? |
| **Tool Efficiency** | Number of tool calls to reach the diagnosis. |
| **Reference Usage** | Did the agent cite specific troubleshooting guides? |
| **Actionability** | Was the proposed fix correct and complete? |

## Scenarios
1.  **pending_resources**: Pod stuck in Pending due to impossible resource requests.
2.  **crash_loop**: Pod crashing because of a missing environment variable.
3.  **image_pull_typo**: Pod failing to start because of a typo in the image name.

## How to Run the Benchmark

### 1. Run Setup
```bash
node eval/benchmark.js
```

### 2. Baseline Test (Without Skill)
Invoke a subagent and instruct it to ignore specialized skills:
> "Troubleshoot the following pods: pending-heavy-pod, crashing-pod, typo-image-pod. Use standard tools only. Do NOT use any specialized troubleshooting manuals."

### 3. Target Test (With Skill)
Invoke the agent normally with the skill active:
> "Use the k8s-troubleshooter skill to diagnose and solve the issues in the 'troubleshoot-eval' namespace."

### 4. Compare Results
Compare the diagnostic depth and accuracy between the two runs.

## Cleanup
```bash
kubectl delete namespace troubleshoot-eval
```
