defmodule TicketisWeb.UserRegistrationLive do
  use TicketisWeb, :live_view

  alias Ticketis.Accounts
  alias Ticketis.Accounts.User

  def render(assigns) do
    ~H"""
    <div class="container mx-auto py-1">
      <div class="flex justify-center px-6 my-4 max-h-fit">
        <div class="w-full xl:w-3/4 lg:w-11/12 flex">
          <div
            class="w-full h-auto bg-gray-400 hidden lg:block lg:w-5/12 bg-cover rounded-l-lg"
            style="background-image: url('https://source.unsplash.com/Mv9hjnEUHR4/600x800')"
          >
          </div>
          <div class="w-full lg:w-7/12 bg-gray-200 p-5 rounded-lg lg:rounded-l-none ">
            <.header class="text-center">
              Crie sua conta!
              <:subtitle>
                Ja tem conta?
                <.link navigate={~p"/users/log_in"} class="font-semibold text-brand hover:underline">
                  Faça login
                </.link>
                na sua conta agora!
              </:subtitle>
            </.header>

            <.simple_form
              for={@form}
              id="registration_form"
              phx-submit="save"
              phx-change="validate"
              phx-drop-target={@uploads.profile_image.ref}
              phx-trigger-action={@trigger_submit}
              action={~p"/users/log_in?_action=registered"}
              method="post"
              class="px-8 py-4 bg-white rounded max-h-fit"
            >
              <.error :if={@check_errors}>
                Oops, something went wrong! Please check the errors below.
              </.error>

              <div class="mb-0 grid grid-cols-2 gap-4">
                <div class="flex flex-col">
                  <label for="text" class="mb-0 font-semibold">Email</label>
                  <.input
                    field={@form[:email]}
                    type="text"
                    id="text"
                    required
                    class="w-full max-w-lg rounded-lg border border-slate-200 px-2 py-1 hover:border-blue-500 focus:outline-none focus:ring focus:ring-blue-500/40 active:ring active:ring-blue-500/40"
                  />
                </div>
                <div class="flex flex-col">
                  <label for="text2" class="mb-0 font-semibold">Senha</label>
                  <.input
                    field={@form[:password]}
                    type="password"
                    id="text2"
                    required
                    class="w-full max-w-lg rounded-lg border border-slate-200 px-2 py-1 hover:border-blue-500 focus:outline-none focus:ring focus:ring-blue-500/40 active:ring active:ring-blue-500/40"
                  />
                </div>
              </div>

              <div class="mb-0 grid grid-cols-2 gap-4">
                <div class="flex flex-col">
                  <label for="text3" class="mb-0 font-semibold">Nome</label>
                  <.input
                    field={@form[:first_name]}
                    type="text"
                    id="text3"
                    required
                    class="w-full max-w-lg rounded-lg border border-slate-200 px-2 py-1 hover:border-blue-500 focus:outline-none focus:ring focus:ring-blue-500/40 active:ring active:ring-blue-500/40"
                  />
                </div>
                <div class="flex flex-col">
                  <label for="text4" class="mb-0 font-semibold">Sobrenome</label>
                  <.input
                    field={@form[:last_name]}
                    type="text"
                    id="text4"
                    required
                    class="w-full max-w-lg rounded-lg border border-slate-200 px-2 py-1 hover:border-blue-500 focus:outline-none focus:ring focus:ring-blue-500/40 active:ring active:ring-blue-500/40"
                  />
                </div>
              </div>

              <div class="mb-0 grid grid-cols-2 gap-4">
                <div class="flex flex-col">
                  <label for="text5" class="mb-0 font-semibold">Telefone</label>
                  <.input
                    field={@form[:phone]}
                    type="text"
                    id="text5"
                    required
                    class="w-full max-w-lg rounded-lg border border-slate-200 px-2 py-1 hover:border-blue-500 focus:outline-none focus:ring focus:ring-blue-500/40 active:ring active:ring-blue-500/40 "
                  />
                </div>
                <div class="flex flex-col">
                  <label for="text6" class="mb-0 font-semibold">CPF</label>
                  <.input
                    field={@form[:cpf]}
                    type="text"
                    id="text6"
                    required
                    class="w-full max-w-lg rounded-lg border border-slate-200 px-2 py-1 hover:border-blue-500 focus:outline-none focus:ring focus:ring-blue-500/40 active:ring active:ring-blue-500/40"
                  />
                </div>
              </div>

              <.input field={@form[:birth_date]} type="date" label="Data de nascimento" required />


              <div class="items-center justify-center font-sans">
                <label
                  for="dropzone-file"
                  class="mx-auto cursor-pointer flex w-full max-w-lg flex-col items-center rounded-xl border-2 border-dashed border-orange-400 bg-white p-6 text-center"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-10 w-10 text-orange-500"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    stroke-width="2"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                    />
                  </svg>

                  <h2 class="mt-4 text-xl font-medium text-gray-700 tracking-wide">Payment File</h2>

                  <p class="mt-2 text-gray-500 tracking-wide">
                    Faça upload ou arraste e solte seu arquivo SVG, PNG, JPG ou GIF.
                  </p>

                  <.live_file_input id="dropzone-file" upload={@uploads.profile_image} class="hidden" />
                </label>
              </div>

              <:actions>
                <.button phx-disable-with="Creating account..." class="w-full">
                  Criar a conta!
                </.button>
              </:actions>
            </.simple_form>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)
      |> assign(:uploaded_files, [])
      |> allow_upload(:profile_image, accept: ~w(.jpg .jpeg), max_entries: 2)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/users/confirm/#{&1}")
          )

        changeset = Accounts.change_user_registration(user)
        {:noreply, socket |> assign(trigger_submit: true) |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_registration(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
