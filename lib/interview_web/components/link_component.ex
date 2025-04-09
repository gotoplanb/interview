defmodule InterviewWeb.LinkComponent do
  use Phoenix.Component

  @doc """
  Renders a link.

  ## Examples

      <.link navigate={~p"/users"}>Users</.link>
      <.link patch={~p"/posts"}>Posts</.link>
  """
  attr :navigate, :any, doc: "the destination route or URL"
  attr :patch, :any, doc: "the destination route or URL"
  attr :href, :any, doc: "the destination route or URL"
  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def link(assigns) do
    ~H"""
    <a
      href={@navigate || @patch || @href}
      class={[
        "hover:text-zinc-700",
        @class
      ]}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </a>
    """
  end
end
