class Monster
  attr_reader :health, :attack

  def initialize
    @health = 30
    @attack = 25
  end

  def attack_player
    return @attack
  end

  def hit_by_player(power)
    @health -= power
    return "killed" if @health <= 0
    return @attack if @health > 0
  end

end
