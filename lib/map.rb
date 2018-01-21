require 'colorize'
class Map

  LEVEL_1 = [
          ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', 'M', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', 'x', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', 'V', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', '#', '#', ' ', '#', '#', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', 'V', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#']
        ]

  def initialize
    @level = LEVEL_1
  end

  def display_map
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
              else
                  print "#{cell} "
              end
          end
          print "\n"
      end
  end

  def move_right
      @level.each do |line|
          cell_counter = 0
          line.each do |cell|
              if cell == 'x'
                  if line[cell_counter + 1] != '#'
                    line[cell_counter] = ' '
                    line[cell_counter + 1] = 'x'
                  end
                  break
              end
              cell_counter += 1
          end
      end
  end

  def move_left
      @level.each do |line|
          cell_counter = 0
          line.each do |cell|
              if cell == 'x'
                  if line[cell_counter - 1] != '#'
                    line[cell_counter] = ' '
                    line[cell_counter - 1] = 'x'
                  end
                  break
              end
              cell_counter += 1
          end
      end
  end

  def move_up
      line_counter = 0
      @level.each do |line|
          cell_counter = 0
          line.each do |cell|
              if cell == 'x'
                  if @level[line_counter - 1][cell_counter] != '#'
                    @level[line_counter][cell_counter] = ' '
                    @level[line_counter - 1][cell_counter] = 'x'
                  end
                  break
              end
              cell_counter += 1
          end
          line_counter += 1
      end
  end

  def move_down
      line_counter = 0
      do_break = false
      @level.each do |line|   # searching the map for player location
          cell_counter = 0
          line.each do |cell|
              if cell == 'x'
                  if @level[line_counter + 1][cell_counter] != '#'    # verifying that the destination cell isn't a wall
                    @level[line_counter][cell_counter] = ' '          # replacing current cell with empty slot
                    @level[line_counter + 1][cell_counter] = 'x'     # replacing the next cell with player, thus 'moving' the player
                  end
                  do_break = true   # this key will exit the parent loop
                  break             # breaking the nested loop
              end
              cell_counter += 1
          end
          line_counter += 1
          break if do_break
      end
  end


end
