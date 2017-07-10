
for a <- 1..100, b <- 1..100, c <- 1..100, a*a + b*b == c*c, do: {a,b,c}

:timer.tc(fn ->
  for a <- 1..100,
      b <- (a+1)..100,
      c <- (b+1)..100,
      a*a + b*b == c*c,
  do: [a, b, c]
end) |> IO.inspect
