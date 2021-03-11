defmodule EventsHwWeb.InviteController do
  use EventsHwWeb, :controller

  alias EventsHw.Invites
  alias EventsHw.Invites.Invite
  alias EventsHw.Photos

  def index(conn, _params) do
    invites = Invites.list_invites()
    render(conn, "index.html", invites: invites)
  end

  def index_event(conn, %{"id" => event_id}) do
    invites = Invites.list_invites_by_event(event_id)
    render(conn, "index.html", invites: invites)
  end

  def new(conn, _params) do
    changeset = Invites.change_invite(%Invite{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"email" => email, "event" => event_id}) do
    IO.puts email
    user = if EventsHw.Users.get_user_by_email(email) == nil do
      photos = Application.app_dir(:events_hw, "priv/photos")
      path = Path.join(photos, "imdying.jfif")
      {:ok, hash} = Photos.save_photo("imdying.jfif", path)
      user_params = %{name: "not_registered", email: email, photo_hash: hash}
      {:ok, user} = EventsHw.Users.create_user(user_params)
      IO.puts "USER CREATED"
      IO.puts user.id
      user
    else
      IO.puts "USER EXISTS"
      EventsHw.Users.get_user_by_email(email)
    end
    IO.puts user.id
    invite_params = %{user_id: user.id, event_id: event_id, comment: "comment", response: "no response"}

    case Invites.create_invite(invite_params) do
      {:ok, invite} ->
        conn
        |> put_flash(:info, "Invite created successfully. Invite Link is /events/#{event_id}")
        |> redirect(to: Routes.event_path(conn, :show, event_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    render(conn, "show.html", invite: invite)
  end

  def edit(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    changeset = Invites.change_invite(invite)
    render(conn, "edit.html", invite: invite, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invite" => invite_params}) do
    invite = Invites.get_invite!(id)

    case Invites.update_invite(invite, invite_params) do
      {:ok, invite} ->
        conn
        |> put_flash(:info, "Invite updated successfully.")
        |> redirect(to: Routes.invite_path(conn, :show, invite))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", invite: invite, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    Invites.update_invite(invite, %{event_id: invite.event_id, user_id: invite.user_id, response: invite.response, comment: ""})
    {:ok, _invite} = Invites.update_invite(invite, %{event_id: invite.event_id, user_id: invite.user_id, response: invite.response, comment: "   "})

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.event_path(conn, :show, invite.event_id))
  end
end
