require 'colorize'
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

  def initialize
    @level = LEVEL_1
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
  end

  def move_right
      do_break = false
      action = nil
      @level.each do |line|
          cell_counter = 0
          line.each do |cell|
              if cell == 'x'
                  if line[cell_counter + 1] != '#'
                    case line[cell_counter + 1]
                    when 'V'
                        action = 'get_vial'
                    when 'M'
                        action = 'attack_monster'
                    when 'W'
                        action = 'get_weapon'
                    when '*'
                        action = 'exit'
                    end
                    line[cell_counter] = ' '
                    line[cell_counter + 1] = 'x'
                  end
                  do_break = true
                  break
              end
              cell_counter += 1
          end
          return action if do_break
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
                        action = 'get_vial'
                    when 'M'
                        action = 'attack_monster'
                    when 'W'
                        action = 'get_weapon'
                    when '*'
                        action = 'exit'
                    end
                    line[cell_counter] = ' '
                    line[cell_counter - 1] = 'x'
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
                        action = 'get_vial'
                    when 'M'
                        action = 'attack_monster'
                    when 'W'
                        action = 'get_weapon'
                    when '*'
                        action = 'exit'
                    end
                    @level[line_counter][cell_counter] = ' '
                    @level[line_counter - 1][cell_counter] = 'x'
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
      @level.each do |line|   # searching the map for player location
          cell_counter = 0
          line.each do |cell|
              if cell == 'x'
                  if @level[line_counter + 1][cell_counter] != '#'    # verifying that the destination cell isn't a wall
                    case @level[line_counter + 1][cell_counter]       # checking for vials and monsters at destination cell
                    when 'V'
                        action = 'get_vial'
                    when 'M'
                        action = 'attack_monster'
                    when 'W'
                        action = 'get_weapon'
                    when '*'
                        action = 'exit'
                    end
                    @level[line_counter][cell_counter] = ' '          # replacing current cell with empty slot
                    @level[line_counter + 1][cell_counter] = 'x'     # replacing the next cell with player, thus 'moving' the player
                  end
                  do_break = true   # this key will exit the parent loop
                  break             # breaking the nested loop
              end
              cell_counter += 1
          end
          line_counter += 1
          return action if do_break   # returning the corresponding action is applicable, or just breaking the parent loop if no actions required
      end
  end


end
