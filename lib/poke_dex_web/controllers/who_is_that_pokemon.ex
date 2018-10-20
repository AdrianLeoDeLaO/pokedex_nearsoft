defmodule PokeDexWeb.WhoIsThatPokemon do
  use PokeDexWeb, :controller

  def f1(conn,_params) do

    url = "https://pokeapi.co/api/v2/pokemon/#{_params["id"]}/"
    response = HTTPoison.get!(url)
    pokemon = JSON.decode!(response.body)["forms"] |> List.first
    name = pokemon["name"]
    result = _params["name"] == name

    json conn, %{success: result, pokemon: name, yours: _params["name"]}
  end



  def whoIs(conn, _params) do
    poke_id = :rand.uniform(151)
    url = "https://pokeapi.co/api/v2/pokemon/#{poke_id}/"
    response = HTTPoison.get!(url)
    pokemon = JSON.decode!(response.body)["forms"] |> List.first

    render conn, "index.html", poke_id: poke_id
  end
end
