fizzbuzz = fn 
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, a -> a
end

show = fn(a,b,c) ->
  IO.puts "{#{a},#{b},#{c}} -> #{fizzbuzz.(a,b,c)}"
end
{a,b,c} = {1,2,3}
show.(a,b,c)
{a,b,c} = {0,2,3}
show.(a,b,c)
{a,b,c} = {0,0,3}
show.(a,b,c)
{a,b,c} = {1,0,3}
show.(a,b,c)

remy = fn n ->
  fizzbuzz.(rem(n,3), rem(n,5), n)
end

Enum.each 10..16, fn x ->
  IO.puts remy.(x)
end
