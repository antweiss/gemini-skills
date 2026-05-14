const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const scenariosDir = path.join(__dirname, 'scenarios');
const scenarios = fs.readdirSync(scenariosDir).filter(f => f.endsWith('.sh'));

const results = [];

async function runBenchmark() {
    console.log("🚀 Starting k8s-troubleshooter Benchmark...");
    console.log("--------------------------------------------");

    for (const scenarioFile of scenarios) {
        const scenarioName = scenarioFile.replace('.sh', '');
        console.log(`\n### Scenario: ${scenarioName}`);
        
        // 1. Setup
        console.log(`   Setting up environment...`);
        execSync(`bash ${path.join(scenariosDir, scenarioFile)}`, { stdio: 'ignore' });

        // 2. Evaluation (Manual or via Agent)
        // In this implementation, we define the "Expected Outcome" 
        // and a placeholder for the comparison.
        
        results.push({
            scenario: scenarioName,
            status: "Ready for Evaluation",
            setup_script: scenarioFile
        });

        console.log(`   ✅ Setup complete. Use Gemini to troubleshoot.`);
    }

    console.log("\n--------------------------------------------");
    console.log("📊 Benchmark Setup Summary");
    console.table(results);
    console.log("\nNext Steps:");
    console.log("1. Run each scenario setup.");
    console.log("2. Prompt Gemini 'Without Skill' (Baseline).");
    console.log("3. Prompt Gemini 'With k8s-troubleshooter' (Target).");
    console.log("4. Compare Accuracy, Tool Calls, and Depth of Diagnosis.");
}

runBenchmark();
