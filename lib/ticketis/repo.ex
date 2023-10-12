defmodule Ticketis.Repo do
  use Ecto.Repo,
    otp_app: :ticketis,
    adapter: Ecto.Adapters.Postgres
end
