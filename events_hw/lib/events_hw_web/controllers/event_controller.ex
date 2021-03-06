defmodule EventsHwWeb.EventController do
  use EventsHwWeb, :controller

  alias EventsHw.Events
  alias EventsHw.Events.Event
  alias EventsHwWeb.Plugs

  plug Plugs.RequireUser when action in [:new, :edit, :create, :update]
  plug :fetch_post when action in [:show, :edit, :update, :delete]
  plug :require_owner when action in [:edit, :update, :delete]

  def require_owner(conn, _args) do
    user = conn.assigns[:current_user]
    event = conn.assigns[:event]

    if user.id == event.user_id do
      conn
    else
      conn
      |> put_flash(:error, "That isn't yours.")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def fetch_post(conn, _args) do
    id = conn.params["id"]
    event = Events.get_event!(id)
    assign(conn, :event, event)
  end

  def index(conn, _params) do
    events = Events.list_events()
    render(conn, "index.html", events: events)
  end

  def new(conn, _params) do
    changeset = Events.change_event(%Event{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"event" => event_params}) do
    event_params = event_params
    |> Map.put("user_id", conn.assigns[:current_user].id)

    case Events.create_event(event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: Routes.event_path(conn, :show, event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    # event = Events.get_event!(id)
    event = conn.assigns[:event]
    invites = Events.get_invites(event.id)
    IO.puts "GOT TO HERE"
    render(conn, "show.html", event: event, invites: invites)
  end

  def edit(conn, %{"id" => id}) do
    # event = Events.get_event!(id)
    event = conn.assigns[:event]
    changeset = Events.change_event(event)
    render(conn, "edit.html", event: event, changeset: changeset)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    # event = Events.get_event!(id)
    event = conn.assigns[:event]
    case Events.update_event(event, event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: Routes.event_path(conn, :show, event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    # event = Events.get_event!(id)
    event = conn.assigns[:event]
    {:ok, _event} = Events.delete_event(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: Routes.event_path(conn, :index))
  end

  def show_invites(conn, %{"id" => id}) do
    invites = Events.get_invites(id)
    render(conn, "show_invites.html", invites: invites)
  end
end
