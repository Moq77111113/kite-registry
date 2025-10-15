-- Create common PostgreSQL extensions

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS "btree_gin";

-- Log successful installation
DO $$
BEGIN
  RAISE NOTICE 'Extensions installed successfully';
END $$;
