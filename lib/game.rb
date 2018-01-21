require_relative "map"
require_relative "player"
require 'pry'

puts "Welcome to the Dungeon Crawler, Ruby edition. By Greg Nalehach"
new_map = Map.new     # creating new instance of a Map

user_input = ''
while user_input.downcase != 'x'  # the loop will be used to stop the game when player hit 'x'
  new_map.display_map   # displaying the current map
  puts "Move the player using arrow keys (← → ↑ ↓) or press 'x' to exit the game"
  user_input = gets.chomp   # getting the user input

  case user_input           # based on the input, moving the player on the map
  when "\e[D"
    new_map.move_left
  when "\e[C"
    new_map.move_right
  when "\e[B"
    new_map.move_down
  when "\e[A"
    new_map.move_up
  end

end
