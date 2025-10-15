# Ansible Docker Setup

Simple Ansible playbook to install and configure Docker + Docker Compose on Ubuntu/Debian servers.

## Features

- ✅ Installs Docker CE
- ✅ Installs Docker Compose
- ✅ Adds users to docker group
- ✅ Configures Docker daemon (logging, storage)
- ✅ Creates default network
- ✅ Enables Docker service on boot
- ✅ Verifies installation

## Quick Start

### 1. Install Ansible
```bash
# Ubuntu/Debian
sudo apt install ansible

# macOS
brew install ansible

# pip
pip install ansible
```

### 2. Edit inventory
```bash
nano inventory.ini

# Add your servers:
[servers]
web1 ansible_host=192.168.1.10 ansible_user=ubuntu
web2 ansible_host=192.168.1.11 ansible_user=ubuntu
```

### 3. Run playbook
```bash
ansible-playbook playbook.yml
```

## Configuration

### Change Docker Compose Version
Edit `playbook.yml`:
```yaml
vars:
  docker_compose_version: "2.23.0"  # Change version
```

### Add More Users to Docker Group
```yaml
vars:
  docker_users:
    - ubuntu
    - deploy
    - jenkins
```

### Custom Docker Daemon Config
Edit the `daemon.json` task in `playbook.yml`:
```yaml
- name: Configure Docker daemon
  copy:
    dest: /etc/docker/daemon.json
    content: |
      {
        "log-driver": "json-file",
        "log-opts": {
          "max-size": "50m",
          "max-file": "5"
        },
        "insecure-registries": ["registry.local:5000"]
      }
```

## Inventory Formats

### INI Format (inventory.ini)
```ini
[web]
web1 ansible_host=10.0.1.10
web2 ansible_host=10.0.1.11

[db]
db1 ansible_host=10.0.2.10

[all:vars]
ansible_user=ubuntu
ansible_python_interpreter=/usr/bin/python3
```

### YAML Format (inventory.yml)
```yaml
all:
  children:
    web:
      hosts:
        web1:
          ansible_host: 10.0.1.10
        web2:
          ansible_host: 10.0.1.11
    db:
      hosts:
        db1:
          ansible_host: 10.0.2.10
  vars:
    ansible_user: ubuntu
    ansible_python_interpreter: /usr/bin/python3
```

## Usage Examples

### Run on specific hosts
```bash
ansible-playbook playbook.yml --limit web1
```

### Run with different user
```bash
ansible-playbook playbook.yml -u root
```

### Check mode (dry run)
```bash
ansible-playbook playbook.yml --check
```

### Verbose output
```bash
ansible-playbook playbook.yml -v    # verbose
ansible-playbook playbook.yml -vvv  # very verbose
```

### Use specific SSH key
```bash
ansible-playbook playbook.yml --private-key ~/.ssh/deploy_key
```

## Verify Installation

### Test Docker
```bash
ansible all -m command -a "docker --version"
ansible all -m command -a "docker ps"
```

### Test Docker Compose
```bash
ansible all -m command -a "docker-compose --version"
```

### Check Docker service
```bash
ansible all -m service -a "name=docker state=started"
```

## Post-Installation

After running the playbook, users need to log out and back in for docker group changes to take effect.

```bash
# Or run this to apply immediately
newgrp docker
```

## What Gets Installed

- **Docker CE** - Latest stable version
- **Docker Compose** - Version specified in vars
- **containerd** - Container runtime
- **Docker CLI tools**

## Customization Examples

### Install Specific Docker Version
```yaml
- name: Install Docker
  apt:
    name:
      - docker-ce=5:24.0.0-1~ubuntu.22.04~jammy
      - docker-ce-cli=5:24.0.0-1~ubuntu.22.04~jammy
      - containerd.io
    state: present
```

### Add Docker Registry
```yaml
- name: Login to private registry
  docker_login:
    registry_url: registry.company.com
    username: deploy
    password: "{{ docker_registry_password }}"
```

### Install Portainer
```yaml
- name: Deploy Portainer
  docker_container:
    name: portainer
    image: portainer/portainer-ce:latest
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
    restart_policy: always
```

## Requirements

- Ubuntu 20.04+ or Debian 11+
- SSH access with sudo privileges
- Python 3 on target servers
- Ansible 2.9+ on control machine

## Troubleshooting

### "Host key verification failed"
```bash
# Add to ansible.cfg
[defaults]
host_key_checking = False

# Or add hosts to known_hosts
ssh-keyscan -H server_ip >> ~/.ssh/known_hosts
```

### "Permission denied (publickey)"
```bash
# Test SSH connection
ssh -i ~/.ssh/id_rsa user@server

# Specify key in inventory
ansible_ssh_private_key_file=~/.ssh/deploy_key
```

### "Module docker_network not found"
```bash
# Install Docker collection
ansible-galaxy collection install community.docker
```

### Package not found
```bash
# Update apt cache first
ansible all -m apt -a "update_cache=yes" --become
```

## Testing

Test connectivity before running:
```bash
ansible all -m ping
```

## Simple!

One command to get Docker running on all your servers. That's it.
