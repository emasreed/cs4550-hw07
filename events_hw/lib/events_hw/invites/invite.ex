defmodule EventsHw.Invites.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invites" do
    field :comment, :string
    field :response, :string
    belongs_to :user, EventsHw.Users.User
    belongs_to :event, EventsHw.Events.Event

    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:comment, :response, :user_id, :event_id])
    |> validate_required([:user_id, :event_id])
  end
end
