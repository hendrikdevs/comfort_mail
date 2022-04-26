defmodule ComfortMail.Repo.Migrations.AddContactStatus do
  use Ecto.Migration

  def change do
    alter table(:contacts) do
      add :status, :string, default: "registered"
    end
  end
end
