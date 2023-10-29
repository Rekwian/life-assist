// Update with your config settings.
// https://knexjs.org/guide/migrations.html
// https://knexjs.org/guide/migrations.html#transactions-in-migrations
module.exports = {

  development: {
    client: 'pg',
    connection: {
      database: 'supabase',
      host: 'localhost',
      password: 'supabase',
      port: 5432,
      user: 'postgres',
    },
    migrations: {
      directory: './migrations',
    },
    seeds: {
      directory: './seeds/dev',
    },
  },

  production: {
    client: 'postgresql',
    connection: {
      database: 'my_db',
      password: 'password',
      user: 'username',
    },
    pool: {
      max: 10,
      min: 2,
    },
  },

  staging: {
    client: 'postgresql',
    connection: {
      database: 'my_db',
      password: 'password',
      user: 'username',
    },
    pool: {
      max: 10,
      min: 2,
    },
  },

};
