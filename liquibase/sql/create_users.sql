DO $$
    BEGIN
        IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'application_role') THEN
            CREATE ROLE application_role WITH LOGIN PASSWORD 'test4321';
        END IF;
        IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'historical_data_role') THEN
            CREATE ROLE historical_data_role WITH LOGIN PASSWORD 'test4321';
        END IF;
        IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'registry_owner_role') THEN
            CREATE ROLE registry_owner_role WITH LOGIN PASSWORD 'test4321';
        END IF;
        IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'registry_template_owner_role') THEN
            CREATE ROLE registry_template_owner_role WITH LOGIN PASSWORD 'test4321';
        END IF;
    END $$;
