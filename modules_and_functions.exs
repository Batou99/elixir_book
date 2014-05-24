defmodule Times do
  def mult(n) do
    fn x -> n*x end
  end

  def triple(number) do
    mult(3).(number)
  end

  def cuadruple(number) do
    mult(4).(number)
  end
end

defmodule Recur do
  defp sum_to(0,acc), do: acc
  defp sum_to(n,acc), do: sum_to(n-1,acc+n)
  def sum_to(n), do: sum_to(n,0)

  def gcd(x,0), do: x
  def gcd(x,y), do: gcd(y, rem(x,y))
end

defmodule Factorial do
  def of(1,acc), do: acc
  def of(n,acc), do: of(n-1,n*acc)
  def of(n) when n>0 do
    of(n,1)
  end
end

defmodule Chop do
  def guess(actual,low..high) do
    mid = low + div(high-low,2)
    _guess(actual,low,mid,high)
  end

  def _guess(mid,_low,mid,_high), do: IO.puts "It's #{mid}"
  def _guess(actual,low,mid,_high) when actual in low..mid-1 do 
  IO.puts "It's #{mid}"
  guess(actual, low..mid-1)
  end
  def _guess(actual,_low,mid,high) when actual in mid..high do 
  IO.puts "It's #{mid}"
  guess(actual, mid..high)
  end
  def _guess(_actual,_low,_mid,_high) do 
  IO.puts "You must be drunk"
  end
end

defmodule MyList do
  def sum([],acc \\ 0), do: acc
  def sum([head | tail], acc), do: sum(tail,acc + head)

  def mapsum([],acc \\ 0, _fun), do: acc
  def mapsum([head | tail], acc, fun), do: mapsum(tail, acc + fun.(head), fun)

  def findmax([]), do: nil
  def findmax([head | tail]), do: _findmax(tail, head)
  defp _findmax([],m), do: m
  defp _findmax([head | tail],m) when head > m do
    _findmax(tail,head)
  end
  defp _findmax([_head | tail],m), do: _findmax(tail,m)

  def caesar([],acc \\ [],_add), do: acc
  def caesar([head | tail], acc, add) do 
  caesar(tail, acc ++ [rem(head + add - ?0, ?z-?0 + 1) + ?0], add) 
  end

  def span(from,to, acc \\ [], step \\ 1) when from>to do
    acc
  end
  def span(from,to,acc,step), do: span(from+step,to,acc ++ [from], step)
end

defmodule MyEnum do
  def all?([], _fun, state \\ true), do: state
  def all?(_, _, false), do: false
  def all?([head | tail], fun, _state) do
    all?(tail,fun, fun.(head))
  end

  def each([], _) do 
  :ok
  end
  def each([head | tail], fun) do
    fun.(head)
    each(tail, fun)
  end

  def filter([], _fun, acc \\ []), do: acc
  def filter([head | tail], fun, acc) do
    if fun.(head) == true do
      filter(tail, fun, acc ++ [head])
    else
      filter(tail, fun, acc)
    end
  end

  def reverse([], acc \\ []), do: acc
  def reverse([head |tail], acc), do: reverse(tail, [head|acc])

  def split(list, point, acc \\ []) when point<0 do
    _split(reverse(list), -point, acc, true)
  end
  def split(list, point, acc), do: _split(list, point, acc, false)

  defp _split(list, 0, acc, false), do: { acc, list }
  defp _split(list, 0, acc, true), do: { reverse(list), reverse(acc) }
  defp _split([head | tail], point, acc, reverse), do: _split(tail, point-1, acc ++ [head], reverse)
  defp _split([], _point, acc, reverse), do: _split([], 0, acc, reverse)

  def take(list, num) do
    { a, _ } = split(list, num) 
    a
  end

  def flatten(x), do: reverse(_flatten(x,[]))
  defp _flatten([],acc), do: acc
  defp _flatten([h|t],acc) when is_list(h) do
    _flatten(t, _flatten(h,acc))
  end
  defp _flatten([h|t],acc), do: _flatten(t, [h|acc])

  def primes(n) when n<2 do
    []
  end
  def primes(n) when is_integer(n) do
    range = MyList.span(2,n)
    range -- (lc a inlist range, b inlist range, a<=b, a*b<=n, do: a*b)
  end

  @orders [
    [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 124, ship_to: :OK, net_amount:  35.50 ],
    [ id: 125, ship_to: :TX, net_amount:  24.00 ],
    [ id: 126, ship_to: :TX, net_amount:  44.80 ],
    [ id: 127, ship_to: :NC, net_amount:  25.00 ],
    [ id: 128, ship_to: :MA, net_amount:  10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    [ id: 120, ship_to: :NC, net_amount:  50.00 ] 
  ]

  @tax_rates [ NC: 0.075, TX: 0.08 ]

  def totals do
    Enum.map @orders, &_total/1 
  end

  defp _total(order_line = [ _, { :ship_to, place }, _]) when place in [:NC, :TX] do
    order_line ++ [total_amount: order_line[:net_amount]*(1+@tax_rates[place])]
  end

  defp _total(order_line), do: order_line ++ [total_amount: order_line[:net_amount]]

end
