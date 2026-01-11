# Open Pull Requests

This document lists the latest open pull requests for the Monster403-cel-zombies_vrpex repository.

## Current Open Pull Requests (as of January 11, 2026)

### PR #1: [WIP] List latest open pull requests
- **Status**: Open (Draft)
- **Created**: January 11, 2026 at 22:45:50 UTC
- **Author**: Copilot (GitHub Bot)
- **Assignees**: Copilot, Monster403-cel
- **Branch**: copilot/list-open-pull-requests → main
- **Link**: https://github.com/Monster403-cel/Monster403-cel-zombies_vrpex/pull/1

---

## Automated Scripts

This repository includes two scripts to programmatically list open pull requests:

### Python Script (Recommended)
```bash
python3 list_open_prs.py
```

### Bash Script
```bash
./list_open_prs.sh
```

Both scripts query the GitHub API and display open pull requests with their details.

---

## Manual Methods to Check for Open Pull Requests

### Using GitHub CLI
```bash
gh pr list --state open --repo Monster403-cel/Monster403-cel-zombies_vrpex
```

### Using GitHub Web Interface
Visit: https://github.com/Monster403-cel/Monster403-cel-zombies_vrpex/pulls

### Using GitHub API (curl)
```bash
curl -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/Monster403-cel/Monster403-cel-zombies_vrpex/pulls?state=open
```

### Using GitHub API (with formatted output)
```bash
curl -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/Monster403-cel/Monster403-cel-zombies_vrpex/pulls?state=open | \
  python3 -m json.tool
```
