require 'spec_helper'

describe User do
  describe "M-N Associations" do
    let(:user)    { create(:user) }
    let(:company) { create(:company) }

    it "has and belongs to many owned companies" do
      user.owned_companies << company

      expect(user.owned_companies).to include(company)
    end

    it "has and belongs to many joined companies" do
      user.joined_companies << company

      expect(user.joined_companies).to include(company)
    end
  end

  describe "Factory" do
    it "creates a valid account" do
      expect( create(:user) ).to be_valid
    end

    it "creates a valid and confirmed account" do
      user = create(:user, :confirmed)

      expect(user).to be_valid
      expect(user).to be_confirmed
    end
  end
end
