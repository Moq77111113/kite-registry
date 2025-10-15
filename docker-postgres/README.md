# Docker PostgreSQL Template

PostgreSQL 15 database with Docker Compose, including persistence, health checks, and initialization scripts.

## Features

- ✅ PostgreSQL 15 Alpine (lightweight)
- ✅ Persistent data volumes
- ✅ Health checks
- ✅ Initialization scripts support
- ✅ Environment-based configuration
- ✅ Common extensions pre-installed

## Quick Start

1. Copy `.env.example` to `.env` and customize:
```bash
cp .env.example .env
```

2. Start the database:
```bash
docker-compose up -d
```

3. Check status:
```bash
docker-compose ps
docker-compose logs -f postgres
```

4. Connect to the database:
```bash
psql -h localhost -U admin -d myapp
```

## Configuration

Edit `.env` file:

```env
POSTGRES_USER=admin
POSTGRES_PASSWORD=your_secure_password
POSTGRES_DB=myapp
POSTGRES_PORT=5432
```

## Initialization Scripts

Place SQL scripts in `init-scripts/` directory. They will run on first startup:

- `01-create-extensions.sql` - Creates common PostgreSQL extensions
- Add your own: `02-schema.sql`, `03-seed-data.sql`, etc.

Files are executed in alphabetical order.

## Backup & Restore

### Backup
```bash
docker-compose exec postgres pg_dump -U admin myapp > backup.sql
```

### Restore
```bash
docker-compose exec -T postgres psql -U admin myapp < backup.sql
```

## Included Extensions

- `uuid-ossp` - UUID generation
- `pg_trgm` - Trigram text search
- `btree_gin` - GIN index support

## Commands

```bash
# Start
docker-compose up -d

# Stop
docker-compose down

# View logs
docker-compose logs -f

# Remove data (WARNING: deletes database)
docker-compose down -v
```
