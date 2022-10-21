defmodule TodoappWeb.TodoLive do
    use TodoappWeb, :live_view

    def mount(_params, _session, socket) do

        todos = [
            %{message: "A", completed: false},
            %{message: "B", completed: false},
            %{message: "C", completed: true}
        ]
        
        socket = 
        socket
        |> assign(:filter, "all" )
        |> assign(:todos, todos )
        |> assign(:filtered_todos, todos )
        {:ok, socket}
    end

    def handle_event("change_filter", %{"filter" => filter}, socket) do
        socket = 
            socket
            |> assign(:filter, filter )
            |> assign(:filtered_todos,
                Enum.filter(socket.assigns.todos, fn todo ->
                    case filter do
                        "all" ->
                            true
                        "active" ->
                            not todo.completed
                        "completed" ->
                            todo.completed   
                    end                 
                end)
            )


        {:noreply, socket}
    end    

    def filter_button(assigns) do
        ~H"""
        <button phx-click="change_filter" 
            phx-value-filter={@filter} 
            style={if @current_filter== @filter, do: "background-color: red", else: ""} 
        >
            <%= @label %>
        </button>
        """
    end
end