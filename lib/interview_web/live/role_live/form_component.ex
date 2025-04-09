defmodule InterviewWeb.RoleLive.FormComponent do
  use InterviewWeb, :live_component

  alias Interview.Roles

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage role records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="role-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="textarea" label="Description" />

        <:actions>
          <.button phx-disable-with="Saving...">Save Role</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{role: role} = assigns, socket) do
    changeset = Roles.change_role(role)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"role" => role_params}, socket) do
    changeset =
      socket.assigns.role
      |> Roles.change_role(role_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"role" => role_params}, socket) do
    save_role(socket, socket.assigns.action, role_params)
  end

  defp save_role(socket, :edit, role_params) do
    case Roles.update_role(socket.assigns.role, role_params) do
      {:ok, role} ->
        notify_parent({:saved, role})

        {:noreply,
         socket
         |> put_flash(:info, "Role updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_role(socket, :new, role_params) do
    case Roles.create_role(role_params) do
      {:ok, role} ->
        notify_parent({:saved, role})

        {:noreply,
         socket
         |> put_flash(:info, "Role created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
