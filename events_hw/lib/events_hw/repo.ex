defmodule EventsHw.Repo do
  use Ecto.Repo,
    otp_app: :events_hw,
    adapter: Ecto.Adapters.Postgres
end
