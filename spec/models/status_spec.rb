require 'spec_helper'

describe Status do
  describe "Factories" do
    it "should have a valid factory" do
      expect(build(:status)).to be_valid
    end
  end

  describe "Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:user)}
  end
end
