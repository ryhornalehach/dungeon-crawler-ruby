require "spec_helper"

RSpec.describe Player do

  let(:new_player) {Player.new}

  describe "#initialize" do
    it "initializes a new '{Player}' object" do
      expect(new_player).to be_a(Player)
    end

    it "has readers for health, level, weapon, attack" do
      expect(new_player.health).to eq(100)
      expect(new_player.level).to eq(1)
      expect(new_player.weapon).to be_nil
      expect(new_player.attack).to eq(25)
    end

    it "does not have reader for xp" do
      expect{new_player.xp}.to raise_error(NoMethodError)
    end
  end

  describe "#get_vial" do
    it "adds health points according to the current level" do
      new_player.get_vial
      expect(new_player.health).to eq(126)
    end
  end

end
