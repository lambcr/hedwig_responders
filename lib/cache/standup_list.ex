defmodule HedwigResponders.Cache.StandupList do
  @cache_name   :responders_cache
  @list_name    "standup_list"
  @default_list Application.get_env(:hedwig_responders, :default_standup_list) || []

  def cache_name,   do: @cache_name
  def list_name,    do: @list_name
  def default_list, do: @default_list

  def show do
    case Cachex.get(cache_name, list_name) do
      {:ok, list}     -> list
      {:missing, nil} -> set(default_list)
    end
  end

  def random do
    show
    |> Enum.take_random(length(show))
  end

  def add(name) do
    show
    |> List.insert_at(0, name)
    |> set
  end

  def remove(name) do
    show
    |> List.delete(name)
    |> set
  end

  def set(list) do
    case Cachex.set(cache_name, list_name, list) do
      {:ok, _} -> list
    end
  end

end

