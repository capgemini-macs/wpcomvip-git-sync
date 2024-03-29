# WP VIP Git Sync

A GitHub Action for syncing between two independent repositories using **force push** to maintain a close collaboraiton between agencies and WP VIP.

## Features
 * Sync branches for review and future merge from external to WP VIP GitHub repository
 * Sync protected WP VIP branches back to external GitHub repository
 * GitHub action can be triggered on a timer or on push

## Usage

### GitHub Actions
```
# File: .github/workflows/repo-sync.yml

on:
  push:
    branches:    
    - 'master'
    - 'develop'

jobs:
  repo-sync:
    runs-on: ubuntu-latest
    steps:
    - name: repo-sync
      uses: capgemini-macs/wpcomvip-git-sync@v0.1.4
      env:
        SOURCE_REPO: ""
        DESTINATION_REPO: ""
        BRANCH: ""
        SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}

```
`SSH_PRIVATE_KEY` can be omitted if using authenticated HTTPS repo clone urls like `https://username:access_token@github.com/username/repository.git`.

## Author
Based on [git-sync] by [Wei He](https://github.com/wei) _github@weispot.com_
Maintained by [Capgemini MACS](https://github.com/capgemini-macs)

## License
[MIT](https://wei.mit-license.org)
