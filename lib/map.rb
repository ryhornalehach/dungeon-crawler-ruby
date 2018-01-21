require 'colorize'
class Map

  LEVEL_1 = [
          ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', '👾', ' ', '#', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', '👳', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', '🍾', ' ', ' ', '#'],
          ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', '#'],
          ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#']
        ]

  def initialize
    @level = LEVEL_1
  end

  def display_map
      @level.each do |line|
          line.each do |cell|
              if cell == '#'
                  print "#{cell} ".light_black
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
              if cell == '👳'
                  if line[cell_counter + 1] != '#'
                    line[cell_counter] = ' '
                    line[cell_counter + 1] = '👳'
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
              if cell == '👳'
                  if line[cell_counter - 1] != '#'
                    line[cell_counter] = ' '
                    line[cell_counter - 1] = '👳'
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
              if cell == '👳'
                  if @level[line_counter - 1][cell_counter] != '#'
                    @level[line_counter][cell_counter] = ' '
                    @level[line_counter - 1][cell_counter] = '👳'
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
      @level.each do |line|
          cell_counter = 0
          line.each do |cell|
              if cell == '👳'
                  if @level[line_counter + 1][cell_counter] != '#'
                    @level[line_counter][cell_counter] = ' '
                    @level[line_counter + 1][cell_counter] = '👳'
                  end
                  break
              end
              cell_counter += 1
          end
          line_counter += 1
      end
  end


end
