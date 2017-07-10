defmodule Hangman do
  alias Hangman.Game

  defdelegate new_game(),  to: Game
  defdelegate make_move(game, guess), to: Game

  def tally(game) do
    { game, tally(game) }
  end
end
