defmodule EventsHw.Repo.Migrations.CreateInvites do
  use Ecto.Migration

  def change do
    create table(:invites) do
      add :event_id, references(:events), null: false
      add :user_id, references(:users), null: false
      add :response, :text
      add :comment, :text

      timestamps()
    end

    create unique_index(:invites, [:event_id, :user_id])

  end
end
