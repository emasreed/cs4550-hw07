defmodule EventsHw.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :text, null: false
      add :email, :text, null: false

      timestamps()
    end

    create index(:users, [:email], unique: true)


  end
end
