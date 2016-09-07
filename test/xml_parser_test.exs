defmodule XmlParserTest do
  use ExUnit.Case
  doctest XmlParser
  import XmlParser, only: [parse: 1]

  describe "parse/1" do
    test "single element with attribute" do
      xml = ~S"""
      <person id="12345">Josh</person>
      """
      data = {:person, %{id: "12345"}, "Josh"}
      assert parse(xml) == data
    end

    test "single element with empty attribute" do
      xml = ~S"""
      <person id="12345"></person>
      """
      data = {:person, %{id: "12345"}, ""}
      assert parse(xml) == data
    end

    test "sibling elements with attributes" do
      xml = ~S"""
      <parent>
        <person id="12345">Josh</person>
        <person id="56789">Bob</person>
        <person id="123">John</person>
      </parent>
      """
      data = {
        :parent, nil, [
          {:person, %{id: "12345"}, "Josh"},
          {:person, %{id: "56789"}, "Bob"},
          {:person, %{id: "123"}, "John"}
        ]
      }
      assert parse(xml) == data
    end

    test "element with attribute and child elements" do
      xml = ~S"""
      <person id="12345"><first>Josh</first><last>Nussbaum</last></person>
      """
      data = {:person, %{id: "12345"}, [{:first, nil, "Josh"}, {:last, nil, "Nussbaum"}]}
      assert parse(xml) == data
    end

    test "elements with namespaces" do
      xml = ~S"""
      <person id="12345">
        <age>33</age>
        <name>Josh Nussbaum</name>
        <name:first>Josh</name:first>
        <name:last>Nussbaum</name:last>
        <city:name id="123">London</city:name>
      </person>
      """
      data = {
        :person, %{id: "12345"}, [
          {:age, nil, "33"},
          {:name, nil, "Josh Nussbaum"},
          {:"name:first", nil, "Josh"},
          {:"name:last", nil, "Nussbaum"},
          {:"city:name", %{id: "123"}, "London"}
        ]
      }
      assert parse(xml) == data
    end
  end
end
