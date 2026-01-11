#!/usr/bin/env python3
"""
Script to list open pull requests for Monster403-cel-zombies_vrpex repository
"""

import json
import urllib.request
import sys

OWNER = "Monster403-cel"
REPO = "Monster403-cel-zombies_vrpex"

def list_open_prs():
    """Fetch and display open pull requests"""
    url = f"https://api.github.com/repos/{OWNER}/{REPO}/pulls?state=open"
    
    print(f"=== Open Pull Requests for {OWNER}/{REPO} ===\n")
    
    try:
        with urllib.request.urlopen(url) as response:
            data = json.loads(response.read().decode())
        
        if not data:
            print("No open pull requests found.")
            return
        
        for pr in data:
            print(f"PR #{pr['number']}: {pr['title']}")
            print(f"  Author: {pr['user']['login']}")
            print(f"  Created: {pr['created_at']}")
            print(f"  Status: {'Draft' if pr.get('draft') else 'Ready for review'}")
            print(f"  URL: {pr['html_url']}")
            print()
    
    except urllib.error.URLError as e:
        print(f"Error fetching pull requests: {e}")
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error parsing response: {e}")
        sys.exit(1)

if __name__ == "__main__":
    list_open_prs()
