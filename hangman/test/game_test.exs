defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "game.letters is all lowercas" do
    game = Game.new_game()
    assert Enum.all?(game.letters, fn(l) -> l =~ ~r/[a-z]/ end)
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert { ^game, _ } = Game.make_move(game, "g") # pin the value of game so it can not change. This line will only
                                                      # match if make_move dosn't change the game
    end
  end

  test "first guess of a letter is accepted" do
    game = Game.new_game()
    { final_game, _ } = Game.make_move(game, "g")

    assert final_game.game_state != :already_guessed
  end

  test "can not guess the same letter twice" do
    game = Game.new_game()
    { game, _ } = Game.make_move(game, "g")
    { final_game, _ } = Game.make_move(game, "g")

    assert final_game.game_state == :already_guessed
  end

end
