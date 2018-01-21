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
    @weapon = 'Knife'
    @attack = 40
  end

  def attack_monster(monster)
      attack_result = monster.hit_by_player(@attack)
      if attack_result != 'killed'
          @health -= attack_result
      else
          return 'killed'
      end
  end

  def display_stats
    puts "Health: #{@health}, Level: #{@level}, Attack: #{@attack}, Weapon: #{@weapon}"
  end


end
