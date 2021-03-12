# EventsHw

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Attribution
Based on Code from https://github.com/NatTuck/scratch-2021-01
and https://github.com/NatTuck/photo_blog

Used flatpickr library for dates and used code from examples.

## Design Decisions
Login will bring you to the events page because that is the main page of the app.
Only invitees will be able to see information about an event, non-invitees will only be able to see the name and the owner. (This is useful for debugging)
When someone is invited and they do not already have an account, an account will be created for them.