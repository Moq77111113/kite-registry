# Kite Template Registry

Demo template registry for [Kite](https://github.com/moq77111113/kite) - the infrastructure template manager.

## What is Kite?

Kite is a simple CLI tool for managing infrastructure templates. Think of it as a flat file manager for DevOps - pull ready-to-use scripts, configs, and automation files into your project.

## Quick Start

```bash
# Initialize Kite in your project
kite init --registry /path/to/kite-registry

# List available templates
kite list

# Add templates to your project
kite add bash-backup-script
kite add github-actions-deploy

# Check for updates
kite update
```

## Available Templates

### 📜 bash-backup-script
Simple bash script for backing up files and databases with rotation.

**What you get:**
- `backup.sh` - Main backup script
- `backup.conf.example` - Configuration template
- Automatic old backup cleanup
- Optional S3 upload support

**Perfect for:** Quick and simple server backups without complex tools.

**Tags:** `bash`, `backup`, `scripts`, `automation`

---

### 🚀 github-actions-deploy
GitHub Actions workflow for deploying Node.js apps via SSH.

**What you get:**
- `.github/workflows/deploy.yml` - Complete CI/CD pipeline
- Test → Lint → Build → Deploy workflow
- Environment protection
- SSH deployment setup

**Perfect for:** Deploying Node.js apps to a VPS/server without complex CI/CD platforms.

**Tags:** `github-actions`, `ci-cd`, `deployment`, `nodejs`

---

### ⚙️ ansible-docker-setup
Ansible playbook for installing Docker on Ubuntu/Debian servers.

**What you get:**
- `playbook.yml` - Docker installation playbook
- `inventory.ini` - Server inventory template
- `ansible.cfg` - Ansible configuration
- Docker + Docker Compose setup
- User group configuration

**Perfect for:** Setting up Docker across multiple servers with one command.

**Tags:** `ansible`, `docker`, `automation`, `infrastructure`

---

### 🐳 docker-postgres
PostgreSQL database with Docker Compose.

**What you get:**
- `docker-compose.yml` - PostgreSQL service definition
- `.env.example` - Environment variables template
- `init-scripts/` - Database initialization scripts
- Health checks and persistence

**Perfect for:** Quick PostgreSQL setup for development or production.

**Tags:** `docker`, `database`, `postgresql`, `docker-compose`

---

### 🔄 gitlab-ci-node
GitLab CI/CD pipeline for Node.js projects.

**What you get:**
- `.gitlab-ci.yml` - Complete pipeline
- Multi-stage: install → lint → test → build → deploy
- Coverage reporting
- Staging and production environments

**Perfect for:** Node.js projects using GitLab CI.

**Tags:** `gitlab`, `ci-cd`, `nodejs`, `testing`, `deployment`

---

### ☁️ terraform-aws-s3
Production-ready AWS S3 bucket with Terraform.

**What you get:**
- `main.tf` - S3 bucket resource
- `variables.tf` - Configurable variables
- `outputs.tf` - Output values
- Versioning, encryption, lifecycle policies

**Perfect for:** Creating secure S3 buckets quickly.

**Tags:** `terraform`, `aws`, `storage`, `s3`

---

## Template Structure

Each template is just a directory with files:

```
template-name/
├── kite.yaml          # Metadata (name, version, description, tags)
├── README.md          # Documentation
└── [your files]       # Scripts, configs, whatever
```

That's it. No complex package formats. Just files.

## Usage

### With Local Registry

```bash
# Clone this registry
git clone https://github.com/YOUR_USERNAME/kite-registry

# Initialize Kite with local path
cd your-project
kite init --registry /path/to/kite-registry

# Add templates
kite add bash-backup-script
```

Files are copied to your project:
```
your-project/
├── kite.json
└── infrastructure/
    └── bash-backup-script/
        ├── backup.sh
        ├── backup.conf.example
        └── README.md
```

### With Git URL

```bash
# Use GitHub URL directly
kite init --registry https://github.com/YOUR_USERNAME/kite-registry

# Kite clones to ~/.kite/cache/registry/
# Then copies files to your project
```

## Why These Templates?

These are intentionally simple, practical templates that small teams actually use:

- **bash-backup-script** - Because not everyone needs Veeam
- **github-actions-deploy** - Because SSH deployments are simple and work
- **ansible-docker-setup** - Because installing Docker manually on 10 servers sucks
- **docker-postgres** - Because `docker-compose up` beats manual installation
- **gitlab-ci-node** - Because most teams use GitLab
- **terraform-aws-s3** - Because S3 is everywhere

No over-engineered Kubernetes manifests. No 500-line Terraform modules. Just useful stuff.

## Contributing

Want to add a template?

1. Fork this repo
2. Create `templates/your-template-name/`
3. Add `kite.yaml`, your files, and `README.md`
4. Submit a PR

**Template guidelines:**
- Keep it simple - if it needs a 10-page README, it's too complex
- Make it practical - solve real problems
- Document it - add a clear README with examples
- Test it - make sure it actually works

## What Kite Is NOT

- ❌ Not a package manager (no dependency resolution)
- ❌ Not a configuration management tool (no templating engine)
- ❌ Not a deployment platform (just copies files)

## What Kite IS

- ✅ A flat file manager for infrastructure code
- ✅ A way to share scripts and configs across projects
- ✅ A simple tool for simple tasks

## License

MIT - Use these templates however you want.

---

**Keep it simple. Keep it practical.**
