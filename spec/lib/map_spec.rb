require "spec_helper"

RSpec.describe Map do

  let(:new_map) {Map.new}

  describe "#initialize" do
    it "initializes a new 'Map' object" do
      expect(new_map).to be_a(Map)
    end

    it "does not have reader for level" do
      expect{new_map.level}.to raise_error(NoMethodError)
    end
  end

  describe ".display_map" do
    it "display the map" do
      expect { new_map.display_map }.to output.to_stdout
    end
  end

  describe ".move_right , .move_left , move_up , move_down" do
    it "moves a player along the map" do
      2.times {new_map.move_right}
      5.times {new_map.move_up}
      expect(new_map.player.health).to eq(75)
      new_map.move_left
      14.times {new_map.move_down}
      new_map.move_left
      expect(new_map.player.weapon).to eq('Knife')
      new_map.move_right
      10.times {new_map.move_up}
      5.times {new_map.move_right}
      new_map.move_down
      expect(new_map.player.health).to eq(101)
      8.times {new_map.move_down}
      4.times {new_map.move_right}
      expect(new_map.player.health).to eq(127)
    end
  end

end
