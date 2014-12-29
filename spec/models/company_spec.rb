require 'spec_helper'

describe Company do
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "M-N Associations" do
    let(:user)    { create(:user) }
    let(:company) { create(:company) }

    it "has and belongs to many owner users" do
      company.owners << user

      expect(company.owners).to include(user)
    end

    it "has and belongs to many members" do
      company.members << user

      expect(company.members).to include(user)
    end
  end

  describe "Factory" do
    it "creates a valid company" do
      expect(create(:company)).to be_valid
    end
  end
end
