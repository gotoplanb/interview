defmodule InterviewWeb.RoleLive.Index do
  use InterviewWeb, :live_view

  alias Interview.Roles
  alias Interview.Roles.Role

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :roles, Roles.list_roles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Role")
    |> assign(:role, Roles.get_role!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Role")
    |> assign(:role, %Role{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Roles")
    |> assign(:role, nil)
  end

  @impl true
  def handle_info({InterviewWeb.RoleLive.FormComponent, {:saved, role}}, socket) do
    {:noreply, stream_insert(socket, :roles, role)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    role = Roles.get_role!(id)
    {:ok, _} = Roles.delete_role(role)

    {:noreply, stream_delete(socket, :roles, role)}
  end

  def handle_event("save", %{"role" => role_params}, socket) do
    save_role(socket, socket.assigns.live_action, role_params)
  end

  defp save_role(socket, :edit, role_params) do
    case Roles.update_role(socket.assigns.role, role_params) do
      {:ok, _role} ->
        {:noreply,
         socket
         |> put_flash(:info, "Role updated successfully")
         |> push_navigate(to: ~p"/roles")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_role(socket, :new, role_params) do
    case Roles.create_role(role_params) do
      {:ok, _role} ->
        {:noreply,
         socket
         |> put_flash(:info, "Role created successfully")
         |> push_navigate(to: ~p"/roles")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
