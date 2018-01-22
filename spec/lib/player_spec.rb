require "spec_helper"

RSpec.describe Player do

  let(:new_player) {Player.new}
  let(:new_monster) {Monster.new}
  let(:new_monster_2) {Monster.new}
  let(:new_monster_3) {Monster.new}
  let(:new_monster_4) {Monster.new}

  describe "# initialize" do
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

  describe ".get_vial" do
    it "adds health points according to the current level" do
      new_player.get_vial
      expect(new_player.health).to eq(126)
    end
  end

  describe ".level_up" do
    it "increases the players level" do
      new_player.level_up
      expect(new_player.level).to eq(2)
    end
    it "increases the players health" do
      new_player.level_up
      expect(new_player.health).to eq(152.8)
    end
    it "increases the players attack" do
      new_player.level_up
      expect(new_player.attack).to eq(27.5)
    end
  end

  describe ".get_weapon" do
    it "gets a weapon in accordance to the players level" do
      new_player.get_weapon
      expect(new_player.weapon).to eq('Knife')
      expect(new_player.attack).to eq(40)
    end
    it "increases the attack power according to the newly aquired weapon" do
      new_player.get_weapon
      expect(new_player.attack).to eq(40)
    end
  end

  describe ".attack_monster" do
    it "decreases the monsters health according to players attack power" do
      new_player.attack_monster(new_monster)
      expect(new_monster.health).to eq(5)
    end
    it "if monster survived the attack - he hits back and players health decreases according to monsters attack power" do
      new_player.attack_monster(new_monster)
      expect(new_player.health).to eq(75)
    end
    it "if monster didnt survive the attack - players health remains unchanged" do
      new_player.get_weapon
      new_player.attack_monster(new_monster)
      expect(new_player.health).to eq(100)
    end
    it "if monster died - players gains experience points according to monsters attack rate and when he get enough xp - he is getting a level raise" do
      new_player.get_weapon
      new_player.attack_monster(new_monster)
      new_player.attack_monster(new_monster_2)
      new_player.attack_monster(new_monster_3)
      new_player.attack_monster(new_monster_4)
      expect(new_player.level).to eq(2)
    end
    it "if monster died, it returns 'killed'" do
      new_player.get_weapon
      expect(new_player.attack_monster(new_monster)).to eq('killed')
    end
  end

  describe ".get_vial" do
    it "adds health points according to the current level" do
      new_player.get_vial
      expect(new_player.health).to eq(126)
    end
  end

end
