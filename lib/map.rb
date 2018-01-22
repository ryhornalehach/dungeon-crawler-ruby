require 'colorize'
require_relative "monster"
require_relative "player"

class Map

  LEVEL_1 = [
          ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '*', '#'],
          ['#', ' ', ' ', ' ', 'M', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', '#', '#', '#', '#', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', 'x', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', 'V', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', '#', '#', ' ', '#', '#', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', '#', '#', '#', '#', '#', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', 'V', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', 'W', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#']
        ]

  WEAPONS = [
      { 'Knife' => 40 },
      { 'Bat' => 55 },
      { 'Axe' => 70 },
      { 'Sword' => 80 },
      { 'Katana' => 90 },
      { 'Chainsaw' => 130 },
      { 'Thor\'s hammer' => 200 },
  ]

  def initialize
    @level = LEVEL_1
    @monster_1 = Monster.new  # creating new instance of Monster
    @player = Player.new      # creating new instance of Player
  end

  def display_map   # displaying the map in a nice format
      @level.each do |line|
          line.each do |cell|
              if cell == '#'
                  print "#{cell} ".light_black
              elsif cell == 'M'
                  print '👾 '      # print monster icon for monsters
              elsif cell == 'V'
                  print '🍾 '      # print bottle icon for vials
              elsif cell == 'x'
                  print '👳 '      # print bottle icon for player
              elsif cell == 'W'
                  print '🗡 '      # print knife icon for weapon
              elsif cell == '*'
                  print '★ '      # print star icon for exit
              else
                  print "#{cell} "
              end
          end
          print "\n"
      end
      @player.display_stats   # displaying the players info after the map
  end

  def move_right
      do_break = false
      action = nil
      @level.each do |line|     # searching the map for player location
          cell_counter = 0
          line.each do |cell|
              if cell == 'x'
                  if line[cell_counter + 1] != '#'    # verifying that the destination cell isn't a wall
                      case line[cell_counter + 1]     # checking for vials and monsters at destination cell
                      when 'V'
                          @player.get_vial            # getting the vial
                          line[cell_counter] = ' '
                          line[cell_counter + 1] = 'x'
                      when 'M'
                          attack_result = @player.attack_monster(@monster_1)    # attack the monster
                          if attack_result == 'killed'    # if the monster was killed - moving the player to the cell
                              line[cell_counter] = ' '
                              line[cell_counter + 1] = 'x'
                          end
                      when 'W'
                          @player.get_weapon        # getting the weapon
                          line[cell_counter] = ' '
                          line[cell_counter + 1] = 'x'
                      when '*'
                          action = 'exit'
                      else
                          line[cell_counter] = ' '      # replacing current cell with empty slot
                          line[cell_counter + 1] = 'x'  # replacing the next cell with player, thus 'moving' the player
                      end
                  end
                  do_break = true   # this key will exit the parent loop
                  break             # breaking the nested loop
              end
              cell_counter += 1
          end
          return action if do_break   # returning the corresponding action is applicable, or just breaking the parent loop if no actions required
      end
  end

  def move_left
      do_break = false
      action = nil
      @level.each do |line|
          cell_counter = 0
          line.each do |cell|
              if cell == 'x'
                  if line[cell_counter - 1] != '#'
                      case line[cell_counter - 1]
                      when 'V'
                          @player.get_vial
                          line[cell_counter] = ' '
                          line[cell_counter - 1] = 'x'
                      when 'M'
                          attack_result = @player.attack_monster(@monster_1)
                          if attack_result == 'killed'
                              line[cell_counter] = ' '
                              line[cell_counter - 1] = 'x'
                          end
                      when 'W'
                          @player.get_weapon
                          line[cell_counter] = ' '
                          line[cell_counter - 1] = 'x'
                      when '*'
                          action = 'exit'
                      else
                          line[cell_counter] = ' '
                          line[cell_counter - 1] = 'x'
                      end
                  end
                  do_break = true
                  break
              end
              cell_counter += 1
          end
          return action if do_break
      end
  end

  def move_up
      line_counter = 0
      do_break = false
      action = nil
      @level.each do |line|
          cell_counter = 0
          line.each do |cell|
              if cell == 'x'
                  if @level[line_counter - 1][cell_counter] != '#'
                      case @level[line_counter - 1][cell_counter]
                      when 'V'
                          @player.get_vial
                          @level[line_counter][cell_counter] = ' '
                          @level[line_counter - 1][cell_counter] = 'x'
                      when 'M'
                          attack_result = @player.attack_monster(@monster_1)
                          if attack_result == 'killed'
                              @level[line_counter][cell_counter] = ' '
                              @level[line_counter - 1][cell_counter] = 'x'
                          end
                      when 'W'
                          @player.get_weapon
                          @level[line_counter][cell_counter] = ' '
                          @level[line_counter - 1][cell_counter] = 'x'
                      when '*'
                          action = 'exit'
                      else
                          @level[line_counter][cell_counter] = ' '
                          @level[line_counter - 1][cell_counter] = 'x'
                      end
                  end
                  do_break = true
                  break
              end
              cell_counter += 1
          end
          line_counter += 1
          return action if do_break
      end
  end

  def move_down
      line_counter = 0
      do_break = false
      action = nil
      @level.each do |line|
          cell_counter = 0
          line.each do |cell|
              if cell == 'x'
                  if @level[line_counter + 1][cell_counter] != '#'
                      case @level[line_counter + 1][cell_counter]
                      when 'V'
                          @player.get_vial
                          @level[line_counter][cell_counter] = ' '
                          @level[line_counter + 1][cell_counter] = 'x'
                      when 'M'
                          attack_result = @player.attack_monster(@monster_1)
                          if attack_result == 'killed'
                              @level[line_counter][cell_counter] = ' '
                              @level[line_counter + 1][cell_counter] = 'x'
                          end
                      when 'W'
                          @player.get_weapon
                          @level[line_counter][cell_counter] = ' '
                          @level[line_counter + 1][cell_counter] = 'x'
                      when '*'
                          action = 'exit'
                      else
                          @level[line_counter][cell_counter] = ' '
                          @level[line_counter + 1][cell_counter] = 'x'
                      end
                  end
                  do_break = true
                  break
              end
              cell_counter += 1
          end
          line_counter += 1
          return action if do_break
      end
  end


end
