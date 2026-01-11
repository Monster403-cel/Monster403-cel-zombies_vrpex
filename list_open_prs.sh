#!/bin/bash
# Script to list open pull requests for Monster403-cel-zombies_vrpex repository

OWNER="Monster403-cel"
REPO="Monster403-cel-zombies_vrpex"

echo "=== Open Pull Requests for $OWNER/$REPO ==="
echo ""

# Fetch open pull requests from GitHub API
response=$(curl -s -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/$OWNER/$REPO/pulls?state=open")

# Check if response is empty or blocked
if [ -z "$response" ] || [[ "$response" == *"Blocked by"* ]]; then
  echo "Error: Unable to fetch pull requests. API may be blocked or unavailable."
  exit 1
fi

# Check if jq is available for proper JSON parsing
if command -v jq &> /dev/null; then
  # Use jq for reliable JSON parsing
  pr_count=$(echo "$response" | jq '. | length' 2>/dev/null)
  
  # Check if jq parsing was successful
  if [ -z "$pr_count" ] || [ "$pr_count" = "null" ]; then
    echo "Error: Unable to parse API response."
    exit 1
  fi
  
  if [ "$pr_count" -eq 0 ]; then
    echo "No open pull requests found."
  else
    echo "$response" | jq -r '.[] | 
      "PR #\(.number): \(.title)",
      "  Author: \(.user.login)",
      "  Created: \(.created_at)",
      "  Status: \(if .draft then "Draft" else "Ready for review" end)",
      "  URL: \(.html_url)",
      ""'
  fi
else
  # Fallback: Basic parsing without jq
  if echo "$response" | grep -q '"number"'; then
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
  else
    echo "No open pull requests found."
    echo "(Note: Install 'jq' for better JSON parsing and error detection)"
  fi
fi
