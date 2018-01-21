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


end
