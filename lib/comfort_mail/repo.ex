defmodule ComfortMail.Repo do
  use Ecto.Repo,
    otp_app: :comfort_mail,
    adapter: Ecto.Adapters.Postgres
end
