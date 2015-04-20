require 'spec_helper'

describe User do

  #describe "Validations" do
  #  it { should validate_presence_of(:phone) }
  #end

  describe "Associations" do
    it { should have_many(:statuses) }
  end
end
