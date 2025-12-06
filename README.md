
---
# Container Security Scan Pipeline

🔒 Container Security Scan Pipeline
An enterprise-grade Azure DevOps pipeline for automated container vulnerability scanning using Trivy.
Automate security scanning, generate compliance reports, send alerts, and maintain audit trails for container images.
![Uploading trivy project .png…]()

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

📋 Table of Contents
* ✨ Features
* 📂 Repository Structure
* 🛠️ Prerequisites
* 🚀 Quick Start
* ⚙️ Configuration
* 🎯 Pipeline Parameters
* 📊 Reports & Outputs
* 🔔 Alerting System
* 🔄 Maintenance
* 🚨 Troubleshooting
* 📚 Best Practices
* 🤝 Contributing

✨ Features
Security Scanning
* 🔍 Comprehensive scanning of all container image tags and layers
* 📅 Scheduled scans (daily/weekly) with customizable cron expressions
* 🎯 Targeted scanning for specific repositories or tags
* 🔄 Automatic Trivy DB updates for latest vulnerability data
Reporting & Compliance
* 📊 Multiple report formats: HTML, CSV, JSON, and SARIF
* 📦 Artifact storage for audit trails and compliance requirements
* 📈 Trend analysis through historical vulnerability data
* 🔍 Detailed vulnerability information including CVSS scores and fixes
Alerting & Integration
* 🚨 Configurable email alerts for high/critical vulnerabilities
* 📱 Slack/Teams integration (optional)
* ⚠️ Severity-based thresholds with customizable limits
* 🔗 Direct links to vulnerability databases and fixes
Operational Excellence
* 🧹 Automatic cleanup of old reports and artifacts
* ⚡ Parallel scanning for faster execution
* 🔐 Secure credential management via Azure DevOps variable groups
* 📝 Comprehensive logging for debugging and auditing

📂 Repository Structure
text
container-security-scan-pipeline/
├── README.md                         # This documentation
├── pipelines/
│   ├── trivy-template.yml           # Reusable Trivy scanning template
│   └── main.yaml                    # Main pipeline definition
└──  scripts/
    └──  update-trivy-db.sh           # Trivy database update script

🛠️ Prerequisites
Azure DevOps Requirements
* ✅ Azure DevOps organization with appropriate licensing
* ✅ Project-level pipeline permissions
* ✅ Service connection to target container registry
* ✅ Variable groups permission for security team
Infrastructure Requirements
* ✅ Agent Pool with:
o Docker runtime installed
o Minimum 4GB RAM (8GB recommended)
o 20GB free disk space
o Outbound internet access for Trivy DB updates
* ✅ Tools:
o jq for JSON processing
o curl for API calls
o trivy (installed via pipeline)
Registry Requirements
* ✅ Read access to container registry
* ✅ Registry credentials (token/service principal)
* ✅ Network connectivity from agent to registry

Clone and Setup

# Review and customize configuration files
code pipelines/main.yaml
code config/trivy-config.yaml

2. Create Variable Group
Create a variable group named container-security-vars in Azure DevOps:
Variable
Description
Example
Required
INTERNAL_REGISTRY_URL
Container registry URL
registry.example.com
✅
BASE_IMAGE_REPO_PATH
Base image repository path
library/ubuntu
✅
TRIVY_IMAGE_REPO_PATH
Trivy image repository path
security/trivy
✅
REGISTRY_USERNAME
Registry username
service-principal
✅
REGISTRY_PASSWORD
Registry access token
********
✅
SECURITY_EMAIL_RECIPIENTS
Comma-separated email list
security@example.com,devops@example.com
✅
ALERT_THRESHOLD_HIGH
High vulnerability threshold
5
✅
ALERT_THRESHOLD_CRITICAL
Critical vulnerability threshold
1
✅
TRIVY_VERSION
Trivy version to use
0.45.0
✅

SCAN_SCHEDULE
Cron schedule for scans
"0 1 * * *"
❌
SLACK_WEBHOOK_URL
Slack webhook for alerts
https://hooks.slack.com/...
❌
3. Import Pipeline
1. Navigate to Azure DevOps → Pipelines
2. Click New Pipeline
3. Select Azure Repos Git
4. Choose your repository
5. Select Existing Azure Pipeline YAML file
6. Path: /pipelines/main.yaml
7. Click Run

   

🎯 Pipeline Parameters
Severity Thresholds
Configure these in your variable group:
Severity
Default Threshold
Response Timeline
Action Required
CRITICAL
1 vulnerability
Immediate
Stop deployment, patch immediately
HIGH
5 vulnerabilities
24 hours
Fix before next release
MEDIUM
(monitor only)
7 days
Include in next sprint
LOW
(monitor only)
30 days
Address during maintenance
Scan Configuration
yaml
# Example: Custom scan configuration in trivy-template.yml
parameters:
  scanConfig:
    vulnType: 'os,library'  # Scan OS and library vulnerabilities
    securityChecks: 'vuln'   # Only vulnerability scanning
    severity: 'CRITICAL,HIGH,MEDIUM,LOW'
    ignoreUnfixed: false     # Report unfixed vulnerabilities
    timeout: 5m              # Per-image timeout
    

📊 Reports & Outputs
Generated Artifacts
After each scan, the pipeline produces:
1. HTML Report (vulnerability-report.html)
o Interactive vulnerability browser
o Severity filtering and sorting
o Fix recommendations and links
2. CSV Report (vulnerability-report.csv)
o Machine-readable format
o Suitable for import into SIEM systems
o Contains: CVE ID, Package, Version, Severity, Fix Version
3. JSON Report (vulnerability-report.json)
o Complete scan results
o Used for programmatic processing
o Includes full vulnerability details
4. SARIF Report (vulnerability-report.sarif)
o Standardized format for security tools
o GitHub Advanced Security compatibility
Report Storage
* Reports are published as Azure DevOps Pipeline Artifacts
* Automatically retained for 90 days (configurable)
* Accessible via Azure DevOps portal or REST API

🔔 Alerting System
Email Alerts
Automatically sent when thresholds are exceeded:
Email Includes:
* 📌 Scan summary and timestamp
* ⚠️ Severity breakdown (Critical/High/Medium/Low)
* 🏷️ List of vulnerable image tags
* 🔗 Direct links to:
o Full HTML report
o Pipeline run
o Vulnerability details
* 🛠️ Recommended remediation steps


Integration Options
yaml
# Add to your variable group for additional integrations
SLACK_WEBHOOK_URL: "https://hooks.slack.com/services/..."
TEAMS_WEBHOOK_URL: "https://outlook.office.com/webhook/..."
OPSGENIE_API_KEY: "your-opsgenie-key"
Alert Content Example
text
🚨 SECURITY ALERT: Container Vulnerabilities Detected

Scan: Daily Security Scan - registry.example.com/library/nginx
Time: 2024-01-15 01:00 UTC
Status: ❌ FAILED (Thresholds exceeded)

📊 Findings:
• CRITICAL: 2 vulnerabilities (threshold: 1)
• HIGH: 7 vulnerabilities (threshold: 5)
• MEDIUM: 15 vulnerabilities
• LOW: 23 vulnerabilities

🔍 Top Critical Vulnerabilities:
1. CVE-2023-12345 (CVSS: 9.8) in libssl1.1
2. CVE-2023-67890 (CVSS: 9.1) in openssl

📎 Reports:
• HTML Report: https://dev.azure.com/.../report.html
• Pipeline Run: https://dev.azure.com/.../runs/123
• CVE Details: https://nvd.nist.gov/vuln/detail/CVE-2023-12345


🚨 Troubleshooting
Common Issues & Solutions
Issue
Symptoms
Solution
Authentication Failures
ERROR: unauthorized
1. Verify registry credentials in variable group
2. Check service principal permissions
3. Ensure token hasn't expired
Network/Proxy Issues
Timeouts, connection refused
1. Verify agent network connectivity
2. Configure proxy in Trivy settings
3. Check firewall rules for registry access
Outdated Database
WARN: DB update required
1. Run update script manually
2. Check cron job execution
3. Verify disk space on agent
Slow Scans
Pipeline timeouts, long execution
1. Increase agent RAM to 8GB+
2. Use --timeout parameter
3. Exclude non-production tags
4. Scan specific tags only
Memory Issues
Container killed, OOM errors
1. Increase agent memory limit
2. Use --memory flag in Trivy
3. Scan fewer images per run
False Positives
Incorrect vulnerability reports
1. Update to latest Trivy version
2. Configure .trivyignore file
3. Verify base image sources
Debug Mode
Enable detailed logging for troubleshooting:
yaml
# Add to pipeline variables
system.debug: true

# Or in script steps
- script: |
    set -x
    trivy image --debug registry/repo:tag
Log Locations
* Pipeline logs: Azure DevOps → Pipelines → Run → Logs
* Trivy logs: trivy.log in pipeline artifacts
* Agent logs: Agent machine /var/log/azure-pipelines/


📚 Best Practices
Security Scanning Strategy
1. Pre-production Scanning: Scan all images before deployment
2. Regular Re-scanning: Schedule weekly scans for running images
3. Base Image Updates: Scan after base image updates
4. Golden Images: Maintain scanned and approved base images
Performance Optimization
* Use dedicated agent pools for security scanning
* Cache Trivy DB between runs
* Schedule scans during off-peak hours
* Parallelize scanning of non-dependent images
Compliance & Auditing
* Retain reports for compliance period (90+ days)
* Regular audit of exclusion lists
* Document all security exceptions
* Integrate with SIEM for centralized logging
Team Collaboration
* Share reports with development teams
* Include security metrics in sprint reviews
* Establish clear vulnerability SLAs
* Regular training on vulnerability remediation


# Validate YAML
az pipelines validate --file pipelines/trivy-template.yml
5. Commit with descriptive messages:
bash
git commit -m "feat: add slack integration for critical alerts"
6. Push and create Pull Request
Contribution Guidelines
* 🔍 Security changes: Require review from security team
* 📝 Documentation: Update README for new features
* 🧪 Testing: Include test cases for new functionality
* 🔧 Backwards compatibility: Maintain existing parameter defaults
* 🎨 Code style: Follow existing YAML/script conventions
Issue Reporting
When reporting issues, please include:
1. Pipeline YAML snippet
2. Error logs (sanitized)
3. Trivy version
4. Agent specifications
5. Steps to reproduce
