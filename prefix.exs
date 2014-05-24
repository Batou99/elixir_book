prefix = fn pref ->
  fn suff ->
    "#{pref} #{suff}"
  end
end

pref = prefix.("Hello")
IO.puts pref.("World")
