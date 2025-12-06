
---
# Container Security Scan Pipeline

This repository provides an enterprise-grade Azure DevOps pipeline for automated container security scanning using Trivy. The pipeline scans container registries, generates vulnerability reports, sends alerts, and stores artifacts for compliance and auditing.

---

## ✨ Features

- 🔒 **Automated scanning** for all container image tags  
- 📊 **HTML & CSV vulnerability reports**  
- 🚨 **Email alerting** for high/critical findings  
- 📅 **Scheduled daily/weekly scans**  
- 📦 **Artifact storage** for compliance  
- 🧹 **Automatic cleanup**  
- 🎯 **Configurable thresholds, exclusions, parameters**

---

## 📂 Repository Structure

container-security-scan-pipeline/
├── README.md
├── pipelines/
│   ├── trivy-template.yml
│   └── main.yaml
├── scripts/
    ├── update-trivy-db.sh
    └── CMD
    
---

## 🛠️ Prerequisites

- Azure DevOps organization  
- Pipeline permissions  
- Container registry read access  
- Agent with:
  - Docker
  - jq
  - curl

---

## 🚀 Installation

### **1. Clone Repository**
```bash
git clone https://github.com/<your-org>/container-security-scan-pipeline

2. Create Variable Group (container-security-vars)
Variable	Description
INTERNAL_REGISTRY_URL	Registry URL
BASE_IMAGE_REPO_PATH	Base image repo path
TRIVY_IMAGE_REPO_PATH	Trivy image repo path
REGISTRY_USERNAME	Registry username
REGISTRY_PASSWORD	Registry token
SECURITY_EMAIL_RECIPIENTS	Email list
ALERT_THRESHOLD_HIGH	High vuln threshold
ALERT_THRESHOLD_CRITICAL	Critical vuln threshold
TRIVY_VERSION	Trivy version

⚙️ Configure Pipeline

Edit azure-pipelines.yml:

pool:
  name: 'Your-Agent-Pool'

resources:
  repositories:
    - repository: Pipeline-Templates
      type: git
      name: 'YourOrg/Templates'
      ref: 'main'

steps:
- template: templates/trivy/trivy-template.yml
  parameters:
    baseImageRepo: 'registry/repo'
    scanName: 'Daily Scan'
    excludedTags: []

▶️ Running the Pipeline
Manual Run

Start from Azure DevOps Pipelines UI.

Scheduled Run
schedules:
  - cron: "0 1 * * *"
    displayName: "Daily 1 AM UTC Scan"
    branches:
      include:
        - main

🔄 Update Trivy Database
./scripts/update-trivy-db.sh


Add to cron:

0 2 * * * /path/to/update-trivy-db.sh >> /var/log/trivy-update.log 2>&1

🚨 Alert Thresholds
Severity	Default	Meaning
CRITICAL	1	Immediate action
HIGH	5	Fix within 24 hours
MEDIUM	None	Monitor
LOW	None	Monitor

Alerts include:

Vulnerable tags

Severity breakdown

Recommended fixes

Links to reports

🧰 Troubleshooting
Issue	Solution
Auth failures	Check registry credentials
Proxy issues	Verify network/firewall
DB outdated	Run update script
Slow scans	Increase agent RAM
Timeouts	Increase timeoutInMinutes

Debug mode:

set -x

🤝 Contributing

Fork repo

Create feature branch

Commit changes

Open PR
