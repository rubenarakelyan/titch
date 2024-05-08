# Titch

A private URL shortener.

## Description

Titch is a simple URL shortener intended to be used privately (i.e. to shorten URLs for your own use) rather than open to the public.

## Quick start (local development)

Ensure Ruby 3.3.0 is installed. Then run:

```
cp .env.example .env
bundle install
docker compose up -d
bin/dev
```

Remember to edit your new `.env` file to set the database and Auth0 details.

MySQL and Redis are run inside Docker containers.

## Short URL previews

A preview page for each short URL can be access by preceding the shortcode with `/p/` (e.g. https://example.com/p/ABCD). This will display the target of the short URL as well as any Open Graph attributes that have been fetched, allowing you to see where the URL leads before following it.

## Authentication providers

Authentication is via Auth0. You will need to sign up with a free account and create an "application" which represents your installation. This will give you the domain, client ID and client secret.

You can control users in the Auth0 management dashboard.

## Background jobs

Sidekiq is used to asynchronously fetch Open Graph attributes for each short URL target and populate the database.

## Environment variables

* `DATABASE_URL`: the connection string used to connect to your MySQL database
* `AUTH0_DOMAIN`: the Auth0 subdomain assigned to your application
* `AUTH0_CLIENT_ID`: the client ID of your Auth0 application
* `AUTH0_CLIENT_SECRET`: the client secret of your Auth0 application

## Testing

`bundle exec rspec`

## Bug reports

Please open an issue on the GitHub repository for any bugs.

## Contributing

All contributions are welcome. Feel free to fork the original GitHub repository, make your changes and then open a Pull Request against the original GitHub repository. Alternatively, if you're not comfortable writing code, please open an issue.

## Licence

[MIT licence](LICENSE)
