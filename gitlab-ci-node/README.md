# GitLab CI/CD for Node.js

Complete CI/CD pipeline for Node.js projects with best practices.

## Features

- ✅ Multi-stage pipeline (install → lint → test → build → deploy)
- ✅ Dependency caching for faster builds
- ✅ Unit and integration testing
- ✅ Code coverage reporting
- ✅ Staging and production deployments
- ✅ PostgreSQL service for integration tests
- ✅ Manual deployment gates

## Pipeline Stages

### 1. Install
- Runs `npm ci` for reproducible builds
- Caches node_modules for 1 hour

### 2. Lint
- Runs code linting
- Must pass for pipeline to continue

### 3. Test
- **Unit tests**: Runs on all branches
- **Integration tests**: Runs on MRs, main, and develop
- Includes PostgreSQL database for integration tests
- Generates coverage reports

### 4. Build
- Builds production artifacts
- Runs only on main, develop, and tags
- Artifacts stored for 1 week

### 5. Deploy
- **Staging**: Manual deployment from develop branch
- **Production**: Manual deployment from main/tags

## Required package.json Scripts

Add these scripts to your `package.json`:

```json
{
  "scripts": {
    "lint": "eslint . --ext .js,.ts",
    "test:unit": "jest --coverage",
    "test:integration": "jest --testPathPattern=integration",
    "build": "your-build-command",
    "deploy:staging": "your-staging-deploy-command",
    "deploy:production": "your-production-deploy-command"
  }
}
```

## GitLab Variables

Set these in GitLab CI/CD Settings → Variables:

```bash
# Deployment credentials
STAGING_API_KEY
PRODUCTION_API_KEY

# Optional: Override defaults
NODE_ENV=production
NPM_CONFIG_CACHE=/path/to/cache
```

## Customization

### Change Node Version
```yaml
image: node:20-alpine  # or node:16, node:18, etc.
```

### Add Environment Variables
```yaml
variables:
  API_URL: "https://api.example.com"
  CUSTOM_VAR: "value"
```

### Add More Services
```yaml
services:
  - postgres:15-alpine
  - redis:7-alpine
```

## Coverage Reports

Coverage is automatically extracted and displayed in merge requests:
- Statement coverage shown as MR metric
- Full report available in pipeline artifacts

## Branch Strategy

- `main` → Production deployments
- `develop` → Staging deployments
- Feature branches → Tests only
- Tags → Production deployments

## Performance

With caching enabled:
- First run: ~3-5 minutes
- Subsequent runs: ~1-2 minutes

Cache is invalidated when `package-lock.json` changes.
