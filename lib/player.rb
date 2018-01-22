require_relative "monster"

class Player
  attr_reader :health, :level, :weapon, :attack

  def initialize
    @health = 100
    @level = 1
    @xp = 0
    @weapon = nil
    @attack = 25
  end

  def get_vial
    @health += ( 20 * (1 + (@level * 0.3)) )
  end

  def get_weapon
    @weapon = Map::WEAPONS[@level - 1].keys[0]
    @attack = Map::WEAPONS[@level - 1].values[0]
  end

  def level_up
    @level += 1
    @health += ( 33 * (1 + (@level * 0.3)) )
    @attack += ( @attack * 0.1 )
  end

  def attack_monster(monster)
      attack_result = monster.hit_by_player(@attack)
      if attack_result != 'killed'
          @health -= attack_result
      else
          @xp += monster.attack
          if ( @xp >= (@level * 100) )
              level_up
              @xp = 0
          end
          return 'killed'
      end
  end

  def display_stats
    puts "Health: #{@health}, Level: #{@level}, Attack: #{@attack}, Weapon: #{@weapon}"
  end

end
