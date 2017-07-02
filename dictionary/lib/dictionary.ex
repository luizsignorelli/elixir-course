defmodule Dictionary do
   def random_word do
     world_list()
     |> Enum.random()
   end

   def world_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
