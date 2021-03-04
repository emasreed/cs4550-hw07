defmodule EventsHw.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :text, null: false
      add :description, :text, null: false
      add :date_time, :naive_datetime, null: false

      timestamps()
    end

  end
end
