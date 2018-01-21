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
    @health += 25
  end

  def attack_monster
    @health -= 25
  end

  def display_stats
    puts "Health: #{@health}, Level: #{@level}, Attack: #{@attack}, Weapon: #{@weapon}"
  end


end
