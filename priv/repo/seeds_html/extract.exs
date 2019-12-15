defmodule SeedExtract do
  defp parse_category(item) do
    item |> Floki.text()
  end

  defp parse_row(row) do
    name = row |> Floki.find(".column-1") |> Floki.text()
    kcalText = row |> Floki.find(".column-2") |> Floki.text()

    %{name: name, kcal: elem(Integer.parse(kcalText), 0)}
  end

  defp parse_table(table) do
    table
    |> Floki.find("tr")
    # skip thead / empty row
    |> Enum.drop(2)
    |> Enum.map(&parse_row/1)
  end

  def get_category_names(html) do
    html
    |> Floki.find("p > strong")
    |> Enum.map(&parse_category/1)
  end

  def get_products(html) do
    html
    |> Floki.find("table[id^=wp-table-reloaded-id]")
    |> Enum.map(&parse_table/1)
  end

  def get_seeds() do
    [1, 2, 3]
    |> Enum.map(fn pageNumber ->
      html = File.read!("priv/repo/seeds_html/part#{pageNumber}.html")

      names = SeedExtract.get_category_names(html)
      products = SeedExtract.get_products(html)

      Enum.zip(names, products)
    end)
    |> Enum.concat()
  end
end
