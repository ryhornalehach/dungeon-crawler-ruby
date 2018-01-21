require "spec_helper"

RSpec.describe Monster do

  let(:new_monster) {Monster.new}

  describe "#initialize" do
    it "initializes a new 'Monser' object" do
      expect(new_monster).to be_a(Monster)
    end

    it "has readers for health and attack" do
      expect(new_monster.health).to eq(30)
      expect(new_monster.attack).to eq(25)
    end
  end

  describe "#attack_player" do
    it "returns a value of attack" do
      expect(new_monster.attack_player).to eq(25)
    end
  end

  describe "#hit_by_player" do
    it "reduces the health by the power value" do
      new_monster.hit_by_player(20)
      expect(new_monster.health).to eq(10)
    end
    it "returns 'killed' if after hit the health went to 0" do
      expect(new_monster.hit_by_player(30)).to eq('killed')
      expect(new_monster.health).to eq(0)
    end
    it "returns 'killed' if after hit the health went below 0" do
      expect(new_monster.hit_by_player(100)).to eq('killed')
      expect(new_monster.health).to eq(-70)
    end
    it "returns attack value if after hit the health remained more than 0" do
      expect(new_monster.hit_by_player(10)).to eq(25)
      expect(new_monster.health).to eq(20)
    end
  end


end
