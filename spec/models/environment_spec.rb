require 'spec_helper'

describe Environment do
  describe "Factories" do
    it "should have a valid factory" do
      expect(build(:environment)).to be_valid
    end
  end

  describe "Validations" do
    it { should belong_to(:status) }
  end
end
