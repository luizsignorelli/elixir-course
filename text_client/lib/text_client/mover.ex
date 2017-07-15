defmodule TextClient.Mover do
  alias TextClient.State
  
  def make_move(game) do
    { new_game_service, new_tally } = Hangman.make_move(game.game_service, game.guess)
    %State{
      game_service: new_game_service ,
      tally:        new_tally,
    }
  end

end
