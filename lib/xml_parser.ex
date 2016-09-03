defmodule XmlParser do
  @moduledoc """
  Parses XML into format that can be consumed by
  [XmlBuilder](https://github.com/joshnuss/xml_builder)
  """

  @doc ~S"""
  Parses provided XML, outputs data for
  [XmlBuilder](https://github.com/joshnuss/xml_builder)

  ## Example
      iex> xml = "<person id=\"12345\"><first>Josh</first><last>Nussbaum</last></person>"
      ...> XmlParser.parse xml
      {:person, %{id: "12345"}, [{:first, nil, "Josh"}, {:last, nil, "Nussbaum"}]}
  """
  def parse(xml) do
    Quinn.parse(xml)
    |> List.first
    |> quinn2xml_parser
  end

  defp quinn2xml_parser(%{attr: attr, name: name, value: value}) do
    {name, parse_attr(attr), quinn2xml_parser(value)}
  end
  defp quinn2xml_parser([value]) when is_binary(value), do: value
  defp quinn2xml_parser([head | tail]) do
    [quinn2xml_parser(head) | quinn2xml_parser(tail)]
  end
  defp quinn2xml_parser([]), do: []

  defp parse_attr([]), do: nil
  defp parse_attr(attr), do: Enum.into(attr, %{})
end
