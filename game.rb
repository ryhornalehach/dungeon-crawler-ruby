require_relative "./lib/map"
require_relative "./lib/player"
require_relative "./lib/monster"
require 'pry'

puts "Welcome to the Dungeon Crawler, Ruby edition. By Greg Nalehach"
puts "Legend: 👳 - player ; 🍾 - health vial ; 👾 - monster ; 🗡 - level exit ; ★ - level exit"
new_map = Map.new     # creating new instance of a Map
# new_player = Player.new   # creating new instance of Player
# new_monster_1 = Monster.new   # creating new instance of Monster

user_input = ''
while user_input.downcase != 'x'  # the loop will be used to stop the game when player hit 'x'
  action = nil
  new_map.display_map   # displaying the current map
  # new_player.display_stats
  puts "Move the player using arrow keys (← → ↑ ↓) or press 'x' to exit the game"
  user_input = gets.chomp   # getting the user input

  case user_input           # based on the input, moving the player on the map
  when "\e[D"
    action = new_map.move_left
  when "\e[C"
    action = new_map.move_right
  when "\e[B"
    action = new_map.move_down
  when "\e[A"
    action = new_map.move_up
  end

  case action
  when "exit"
    user_input = 'x'
  end

end
