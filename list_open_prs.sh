#!/bin/bash
# Script to list open pull requests for Monster403-cel-zombies_vrpex repository

OWNER="Monster403-cel"
REPO="Monster403-cel-zombies_vrpex"

echo "=== Open Pull Requests for $OWNER/$REPO ==="
echo ""

# Fetch open pull requests from GitHub API
response=$(curl -s -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/$OWNER/$REPO/pulls?state=open")

# Parse and display the results
echo "$response" | grep -E '"number"|"title"|"html_url"|"created_at"' | \
  awk 'BEGIN { count=0; } 
  /"number"/ { count++; number=$2; gsub(/,/, "", number); }
  /"title"/ { 
    title=$0; 
    sub(/.*"title": "/, "", title); 
    sub(/",$/, "", title); 
  }
  /"html_url"/ { 
    url=$0; 
    sub(/.*"html_url": "/, "", url); 
    sub(/",$/, "", url); 
  }
  /"created_at"/ { 
    created=$0; 
    sub(/.*"created_at": "/, "", created); 
    sub(/",$/, "", created); 
    print "PR #" number ": " title;
    print "  Created: " created;
    print "  URL: " url;
    print "";
  }'

# If no PRs found
if ! echo "$response" | grep -q '"number"'; then
  echo "No open pull requests found."
fi
