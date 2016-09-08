[![Build Status](https://travis-ci.org/denispeplin/xml_parser.svg?branch=master)](https://travis-ci.org/denispeplin/xml_parser)
[![Hex Version](https://img.shields.io/hexpm/v/xml_parser.svg)](https://hex.pm/packages/xml_parser)

# XmlParser

This parser transforms `XML` to a format that can be consumed by
[XmlBuilder](https://github.com/joshnuss/xml_builder).

Currently this parser is just a wrapper around
[Quinn](https://github.com/nhu313/Quinn) parser.

It can be rewritten to gain more performance.

## Installation

The package can be installed as:

  1. Add `xml_parser` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:xml_parser, "~> 0.1.0"}]
    end
    ```

  2. Ensure `xml_parser` is started before your application:

    ```elixir
    def application do
      [applications: [:xml_parser]]
    end
    ```

## Usage

```elixir
xml = "<person id=\"12345\"><first>Josh</first><last>Nussbaum</last></person>"
data = XmlParser.parse xml
# {:person, %{id: 12345}, [{:first, nil, "Josh"}, {:last, nil, "Nussbaum"}]}
# and don't forget to include xml_builder into deps before using it
XmlBuilder.build data
# <person id="12345"><first>Josh</first><last>Nussbaum</last></person>
```

[Documentation](https://hexdocs.pm/xml_parser/0.1.0/XmlParser.html) is also available.

## Gotchas

`Quinn` can't parse XML with siblings on the top level of a document, so XML document must
have only one root element.

```xml
<good>
  <data>Data!</data>
  <data>More data!</data>
</good>
```

```xml
<bad>Data!</bad>
<bad>Lost data</bad>
```
