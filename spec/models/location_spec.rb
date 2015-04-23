require 'spec_helper'

describe Location do
  describe "Factories" do
    it "should have a valid factory" do
      expect(build(:location)).to be_valid
    end
  end

  describe "Validations" do
    it { should belong_to(:status) }
  end
end
