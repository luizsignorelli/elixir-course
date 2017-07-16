defmodule TextClient.Player do
  alias TextClient.{State, Summary, Prompter, Mover}

  # possible states: won, lost, good_guess, bad_guess, already used, initializing

  def play(game = %State{tally: %{game_state: :won}}) do
    IO.puts("- Final state\n\n")
    Summary.display(game)
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

  def play(game = %State{tally: %{game_state: :already_guessed}}) do
    continue_with_message(game, "You already guessed that one.")
  end

  def play(game = %State{tally: %{game_state: :initializing}}) do
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
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
