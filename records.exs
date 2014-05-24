defmodule Records do

  @tax_rates [ NC: 0.075, TX: 0.08 ]

  defrecord Sale, id: nil, ship_to: :NY, amount: 100, sales_tax: 0

  def read(filename) do
    file = File.open! filename
    headers = IO.read(file, :line)
    Enum.each(IO.stream(file, :line), &process_line/1)
    #Enum.each File.stream!(filename, [:read]), &process_line/1 #|> IO.puts
  end

  def process_line(string) do
    data = String.split(string, ",")
    process_data data
  end

  def maybe_convert_value(value) do
    cond do
      Regex.match?(~r/^\d+$/, value) -> binary_to_integer(value)
      Regex.match?(~r/^\d+\.\d+$/, value) -> binary_to_float(value)
      << ?: :: utf8, name :: binary >> = value -> binary_to_atom(name)
      true -> value
    end
  end

  def process_data([id, ship_to, amount]) do
    IO.puts maybe_convert_value(id)
    #id = binary_to_integer Enum.at data, 0
    #ship_to = binary_to_atom String.lstrip Enum.at data,1, ?:
    #amount = binary_to_float Enum.at data, 2
    #sales_tax = get_sales_tax ship_to, amount
    #Sale.new id: id, ship_to: ship_to, amount: amount, sales_tax: sales_tax
  end

  def process_data([id, ship_to, amount]) do
  end

  def get_sales_tax(ship_to, amount) when ship_to in [:TX, :NC] do
    amount*(1+@tax_rates[ship_to])
  end

  def get_sales_tax(_ship_to, amount) do
    amount
  end
end
