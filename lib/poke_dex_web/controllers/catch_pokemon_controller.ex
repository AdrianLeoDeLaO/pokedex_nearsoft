defmodule PokeDexWeb.CatchPokemonController do
  use PokeDexWeb, :controller

  def index(conn, %{"i" => i}) do
    c = (("https://pokeapi.co/api/v2/pokemon-species/#{i}/" |> HTTPoison.get!).body |> JSON.decode!)["capture_rate"]
    r = HTTPoison.get!("https://pokeapi.co/api/v2/pokemon/#{i}/")
    p = JSON.decode!(r.body)["forms"] |> List.first
    
    params = %{c: c, r: r, p: p, i: i}

    render conn, "index.html", params: params
  end

end
