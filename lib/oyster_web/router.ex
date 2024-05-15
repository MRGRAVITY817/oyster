defmodule OysterWeb.Router do
  use OysterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {OysterWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  live_session :default, on_mount: [{OysterWeb.SaveRequestUri, :save_request_uri}] do
    pipe_through :browser

    live("/", OysterWeb.Pages)
    live("/docs", OysterWeb.Pages.Docs)
    live("/docs/components/avatar", OysterWeb.Pages.Docs.Components.Avatar)
  end

  # Other scopes may use custom stacks.
  # scope "/api", OysterWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard in development
  if Application.compile_env(:oyster, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      live_dashboard "/dashboard", metrics: OysterWeb.Telemetry
    end
  end
end
