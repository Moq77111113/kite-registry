# GitHub Actions Deploy

Simple GitHub Actions workflow for deploying Node.js applications to a production server via SSH.

## Features

- ✅ Runs tests before deploying
- ✅ Lints code
- ✅ Builds production bundle
- ✅ SSH deployment to server
- ✅ Environment protection
- ✅ Manual trigger support

## Setup

### 1. Add GitHub Secrets

Go to your repository → Settings → Secrets and variables → Actions

Add these secrets:
- `SSH_PRIVATE_KEY` - Your SSH private key for deployment
- `SERVER_HOST` - Your server hostname/IP
- `SERVER_USER` - SSH username

### 2. Configure Environment

Go to Settings → Environments → New environment

Create `production` environment with protection rules (optional).

### 3. Update Workflow

Edit `.github/workflows/deploy.yml`:

```yaml
# Change deployment path
cd /var/www/myapp  # ← Your app path

# Change process name
pm2 restart myapp  # ← Your PM2 app name
```

## Usage

### Automatic Deployment
Push to `main` branch triggers deployment automatically:
```bash
git push origin main
```

### Manual Deployment
Go to Actions → Deploy to Production → Run workflow

## Requirements

### On Your Server
- Node.js installed
- PM2 process manager (`npm install -g pm2`)
- App directory created: `/var/www/myapp`

### In package.json
```json
{
  "scripts": {
    "test": "jest",
    "lint": "eslint .",
    "build": "your-build-command"
  }
}
```

## SSH Key Setup

### Generate deployment key
```bash
ssh-keygen -t ed25519 -C "github-deploy" -f deploy_key
```

### Add public key to server
```bash
ssh-copy-id -i deploy_key.pub user@server
```

### Add private key to GitHub
Copy contents of `deploy_key` and add to GitHub Secrets as `SSH_PRIVATE_KEY`.

## Customization

### Different Node Version
```yaml
- uses: actions/setup-node@v4
  with:
    node-version: '20'  # Change version
```

### Deploy Without PM2
```yaml
# Replace PM2 restart with:
systemctl restart myapp
# or
docker-compose restart
```

### Add Slack Notification
```yaml
- name: Slack Notification
  uses: slackapi/slack-github-action@v1
  with:
    webhook-url: ${{ secrets.SLACK_WEBHOOK }}
    payload: |
      {
        "text": "Deployment successful! 🚀"
      }
```

## Troubleshooting

### SSH Connection Failed
- Check server is accessible: `ssh user@server`
- Verify SSH key in GitHub Secrets
- Check server firewall allows SSH

### Tests Failed
- Run tests locally first: `npm test`
- Check test logs in Actions tab

### PM2 Not Found
```bash
# Install PM2 on server
npm install -g pm2

# Start your app with PM2
pm2 start npm --name "myapp" -- start
pm2 save
```

## What Happens on Deploy

1. ✅ Tests run on GitHub runner
2. ✅ Code is linted
3. ✅ Production build created
4. ✅ Files packaged as tar.gz
5. ✅ Uploaded to server via SCP
6. ✅ Extracted in app directory
7. ✅ PM2 restarts app
8. ✅ Old files cleaned up

## Simple!

This is a straightforward deployment workflow. No complex CI/CD platforms needed, just GitHub Actions and SSH.
