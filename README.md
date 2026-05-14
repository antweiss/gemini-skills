# Gemini CLI Skills Collection

This repository is a collection of specialized [Gemini CLI](https://geminicli.com) skills designed to extend the agent's capabilities with domain-specific knowledge, workflows, and automated tools.

## Skills

### ☸️ k8s-troubleshooter

The `k8s-troubleshooter` skill transforms Gemini CLI into a senior Kubernetes engineer. It provides expert diagnostic guidance, automated tool installation, and structured troubleshooting workflows.

#### Key Features
- **Deep Knowledge Base**: Comprehensive reference guides for Networking (DNS, Ingress), Storage (PVCs, permissions), Security (RBAC, Pod Security Standards), and Pod Lifecycle (Exit codes, OOMKills).
- **Tool Management**: Automatically checks for and installs essential tools: `kubectl`, `stern` (log tailing), and `k9s` (terminal UI).
- **Diagnostic Decision Tree**: Guided workflows to quickly move from symptoms to root cause identification.
- **Evidence-Based**: Based on the established patterns found in [The Ultimate Kubernetes Troubleshooting Guide by PerfectScale](https://info.perfectscale.io/kubernetes-troubleshooting-guide).

#### Installation

Install the skill globally in your Gemini CLI environment:

```bash
gemini skills install https://github.com/antweiss/gemini-skills.git --path k8s-troubleshooter
```

*Note: After installation, remember to run `/skills reload` in your active Gemini CLI session.*

#### Self-Evaluation

This skill includes an embedded evaluation suite to verify its diagnostic capabilities.

1. **Setup Scenario**: Run the setup script to create a broken "Pending" pod:
   ```bash
   bash k8s-troubleshooter/eval/scenario_pending.sh
   ```
2. **Invoke Troubleshooting**: Ask Gemini:
   > "I have a pod stuck in Pending in the 'troubleshoot-eval' namespace. Can you find out why and tell me how to fix it?"
3. **Verify**: Gemini should use the skill's logic to identify the resource exhaustion and suggest a fix.

#### Benchmark Results
A standard benchmark was performed comparing Gemini CLI's performance with and without this skill across 3 diagnostic scenarios (Pending, CrashLoop, ImagePull).
- **Reference Usage**: 100% (The skill-enabled agent cited specific diagnostic guides for every issue).
- **Diagnostic Depth**: Significantly higher with the skill, providing architectural context instead of just symptomatic fixes.
See [benchmark_results.md](k8s-troubleshooter/eval/benchmark_results.md) for full details.

---

## Contributing
Contributions of new skills or improvements to existing ones are welcome! Ensure each skill follows the [Skill Creator](https://geminicli.com/docs/skills/creation) standards.
