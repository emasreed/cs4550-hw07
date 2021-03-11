defmodule EventsHw.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :user_id, references(:users), null: false
      add :name, :text, null: false
      add :description, :text, null: false
      add :date_time, :naive_datetime, null: false

      timestamps()
    end

  end
end
