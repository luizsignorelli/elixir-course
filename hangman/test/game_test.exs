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
      assert ^game = Game.make_move(game, "g") # pin the value of game so it can not change. This line will only
                                                      # match if make_move dosn't change the game
    end
  end

  test "first guess of a letter is accepted" do
    game = Game.new_game()
    final_game = Game.make_move(game, "g")

    assert final_game.game_state != :already_guessed
  end

  test "can not guess the same letter twice" do
    game = Game.new_game()
    game = Game.make_move(game, "g")
    final_game = Game.make_move(game, "g")

    assert final_game.game_state == :already_guessed
  end

  test "a good guess" do
    game = Game.new_game("galo")
    game = Game.make_move(game, "g")

    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "win game" do
    moves = [
      {"g", :good_guess},
      {"a", :good_guess},
      {"l", :good_guess},
      {"o", :won}
    ]

    game = Game.new_game("galoo")
    Enum.reduce(moves, game, fn({guess, state}, new_game) ->
      new_game = Game.make_move(new_game, guess)
      assert new_game.game_state == state
      assert game.turns_left == 7
      new_game
    end)

    # game = Game.make_move(game, "g")
    # assert game.game_state == :good_guess
    # assert game.turns_left == 7
    #
    # game = Game.make_move(game, "a")
    # assert game.game_state == :good_guess
    # assert game.turns_left == 7
    #
    # game = Game.make_move(game, "l")
    # assert game.game_state == :good_guess
    # assert game.turns_left == 7
    #
    # game = Game.make_move(game, "o")
    # assert game.game_state == :won
    # assert game.turns_left == 7
  end

  test "bad guess, still have turns_left" do
    game = Game.new_game("galoo")
    game = Game.make_move(game, "c")

    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost the game" do
    game = Game.new_game("galo")
    game = Game.make_move(game, "c")
    game = Game.make_move(game, "i")
    game = Game.make_move(game, "d")
    game = Game.make_move(game, "f")
    game = Game.make_move(game, "v")
    game = Game.make_move(game, "b")
    game = Game.make_move(game, "p")

    assert game.game_state == :lost
    assert game.turns_left == 0
  end

end
