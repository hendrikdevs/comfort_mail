defmodule ComfortMailWeb.Router do
  use ComfortMailWeb, :router

  @default_content_security_policy %{"Content-Security-Policy" => "default-src 'self'"}

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ComfortMailWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers, @default_content_security_policy
  end

  pipeline :api do
    plug :accepts, ["json", "html"]
    plug :put_secure_browser_headers, @default_content_security_policy
  end

  scope "/", ComfortMailWeb do
    pipe_through :browser

    live "/", IndexLive.Index, :index
    live "/register", IndexLive.Register, :register


    get "/register/:id", RegistrationController, :activate

    live "/contacts", ContactLive.Index, :index
    live "/contacts/new", ContactLive.Index, :new
    live "/contacts/:id/edit", ContactLive.Index, :edit

    live "/contacts/:id", ContactLive.Show, :show
    live "/contacts/:id/show/edit", ContactLive.Show, :edit
  end

  scope "/submit", ComfortMailWeb do
    pipe_through :api

    post "/:email", SubmitController, :submit
  end

  scope "/submit", ComfortMailWeb do
    pipe_through :browser

    get "/success", SubmitController, :success
    get "/failure", SubmitController, :failure
  end

  # Other scopes may use custom stacks.
  # scope "/api", ComfortMailWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ComfortMailWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
