defmodule MyString do
  def printable?(''), do: true
  def printable?([head | tail]) when head in ? ..?~ do
    printable?(tail)
  end
  def printable?(_), do: false

  def printable2?(chars), do: Enum.all?(chars, fn x -> x in ? ..?~ end)

  def anagram?(word1, word2) do
    Enum.sort(word1) == Enum.sort(word2)
  end

  def parse( data, first \\ [], last \\ [])
  def parse( [ ? | tail], first, last), do: parse(tail,first,last)
  def parse([], first, last) do 
    [oper | num] = last 
    { first, oper, num}
  end
  def parse( [ head | tail ], [],[]), do: parse(tail,[head],[])
  def parse( [ head | tail ], first,[]) when head in ?0..?9 do 
    parse(tail,first ++ [head],[])
  end
  def parse( [ head | tail ], first,[]) do 
    parse(tail,first,[head])
  end
  def parse( [ head | tail ], first,last), do: parse(tail, first, last ++ [head])

  def calculate(str), do: _calculate(str,0)

  defp _calculate([], acc), do: acc
  defp _calculate([? | tail], acc), do: _calculate(tail,acc)
  defp _calculate([digit | tail], acc) when digit in ?0..?9, do: _calculate(tail, acc * 10 + digit - ?0)
  defp _calculate([operator | tail], acc) when operator in '+/-*', do: apply(:erlang, list_to_atom([operator]), [acc, calculate(tail)])

  def center(list) do
    max = list |> Enum.map(&String.length/1) |> Enum.max
    lc elem inlist list do
      IO.puts _center(elem,max)
    end
  end

  defp _center(string, size) do 
    length = String.length string
    final_size = Enum.max [length, size]
    left = div(final_size-length, 2)
    String.rjust(String.ljust(string, length + left), final_size)
  end

  def capitalize_sentences(str) do
    str |> String.split(%r{\.\s+}) 
        |> Enum.map(&String.capitalize(&1)) 
        |> Enum.join(". ")
  end
  
end

defmodule MyFile do
  def read(filename) do
    Enum.each File.stream!(filename,[:read]), &process_line/1
  end

  def process_line(string) do
    process_data String.split(string,",")
  end

  def process_data([id, location, amount]) when is_integer(id) do
    {id, location, amount}
  end
end
