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
    it { should validate_presence_of(:user) }
    it { should ensure_inclusion_of(:status_type).in_array(["status","event"]) }
  end

  describe "Associations" do
    it { should have_one(:location) }
    it { should have_one(:environment) }
  end
end
