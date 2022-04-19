<?php

return array (
  'APP_ENV' => 'prod',
  'APP_DEBUG' => '0',
  'APP_SECRET' => 'NOTANYMORE',
  'DATABASE_URL' => 'mysql://sylius:sylius@compose_db_1/sylius',
  'MAILER_URL' => 'smtp://localhost',
  'JWT_SECRET_KEY' => '%kernel.project_dir%/config/jwt/private.pem',
  'JWT_PUBLIC_KEY' => '%kernel.project_dir%/config/jwt/public.pem',
  'JWT_PASSPHRASE' => '66d45daf91b2ed1031e62d81c81dba2e',
  'MESSENGER_TRANSPORT_DSN' => 'doctrine://default',
);
