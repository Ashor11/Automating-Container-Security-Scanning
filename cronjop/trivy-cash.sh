#!/bin/bash
# Simple script to update Trivy database

echo "Updating Trivy database at $(date)"
echo "Cache location: ~/trivy/trivy-cache"

# Update database
trivy --cache-dir ~/trivy/trivy-cache image --download-db-only

if [ $? -eq 0 ]; then
    echo "✅ Database updated successfully"
    
    # Show database info
    echo ""
    echo "Database info:"
    trivy --cache-dir ~/trivy/trivy-cache image --download-db-only 2>&1 | grep -A2 "DB info"
    
    echo ""
    echo "Cache contents:"
    ls -la ~/trivy/trivy-cache/
else
    echo "❌ Database update failed"
fi
