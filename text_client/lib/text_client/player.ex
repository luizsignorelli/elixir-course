defmodule TextClient.Player do
  alias TextClient.State
  # possible states: won, lost, good_guess, bad_guess, already used, initialising

  def play(%State{tally: %{game_state: :won}}) do
    exit_with_message("You won!!")
  end

  def play(%State{tally: %{game_state: :lost}}) do
    exit_with_message("Sorry, you lost :(")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "Ouch! Bad guess, sorry.")
  end

  def continue(game) do
    game
    |> display()
    |> prompt()
    |> make_move()
    |> play()
  end

  defp display(game) do
    game
  end

  defp prompt(game) do
    game
  end

  defp make_move(game) do
    game
  end

  defp continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end

end
