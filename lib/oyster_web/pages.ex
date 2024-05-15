defmodule OysterWeb.Pages do
  use OysterWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
      <a href="/docs/components/avatar" class="text-blue-400 text-xl">
        Avatar
      </a>
    </div>
    """
  end
end
