defmodule Lists do
  def len( [] ), do: 0
  def len( [_h|tail] ), do: 1 + len(tail)

  def sum( [] ), do: 0
  def sum( [head|tail] ), do: head + sum(tail)

  def double( [] ), do: []
  def double( [ head | tail ] ), do: [ 2*head | double(tail) ]

  def square( [] ), do: []
  def square( [ head | tail ] ), do: [ head*head | square(tail) ]

  def sum_pairs( [] ), do: []
  def sum_pairs( [ h1, h2 | tail ] ), do: [ h1+h2 | sum_pairs(tail) ]

  def even_length?( [] ), do: false
  def even_length?( [_] ), do: true
  def even_length?( [ _h1,_h2 | t ] ), do: even_length?(t)

end
