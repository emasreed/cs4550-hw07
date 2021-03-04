defmodule EventsHw.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :date_time, :naive_datetime
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :description, :date_time])
    |> validate_required([:name, :description, :date_time])
  end
end
