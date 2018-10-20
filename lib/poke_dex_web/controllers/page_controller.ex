defmodule PokeDexWeb.PageController do
  use PokeDexWeb, :controller
  require Logger

  def index(conn, _params) do
    render conn, "index.html"
  end

  def search(conn, %{"q" => query}) do
    #url = "https://pokeapi.co/api/v2/pokemon/#{i}/"
    #response = HTTPoison.get url
    #simon = Poison.Parser.parse response
    
    response = (("https://pokeapi.co/api/v2/pokemon/#{query}/" |> HTTPoison.get!).body |> Poison.Parser.parse!)
    
    name = (response["forms"] |> List.first) ["name"]
    id = response["id"]
    types = response["types"]
    front_image = response["sprites"]["front_default"]
    back_image = response["sprites"]["back_default"]

    pokemon = %{name: name, id: id, types: types, front_image: front_image, back_image: back_image}
    
    render conn, "search.html", pokemon: pokemon
  end

end
