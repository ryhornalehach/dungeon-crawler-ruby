class Player
  attr_reader :health, :level, :weapon, :attack

  def initialize
    @health = 100
    @level = 1
    @xp = 0
    @weapon = nil
    @attack = 25
  end


end
