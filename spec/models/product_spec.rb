require 'spec_helper'

describe Product do
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should have_attached_file(:image) }

    it { should validate_attachment_presence(:image) }

    it { should validate_attachment_content_type(:image).
                allowing('image/jpg', 'image/jpeg', 'image/png', 'image/gif').
                rejecting('text/plain', 'text/xml') }

    it { should validate_attachment_size(:image).
                less_than(5.megabytes) }
  end

  let(:product) { create :product }
  let(:user)    { create(:user) }
  let(:company) { create(:company) }

  describe "Factory" do
    it "create a valid product" do
      expect(create(:product)).to be_valid

    end
  end

  describe "Associations" do
    it { should belong_to(:user)}
    it { should belong_to(:company)}
  end

  describe "finders" do
    describe "#latest" do
      let!(:products) { create_list(:product, 10) }

      it "returns five products" do
        expect(Product.latest.count).to eql(5)
      end

      it "lists newer records first" do
        latest = Product.latest

        expect(latest).to include(products[9])
        expect(latest).to include(products[8])
        expect(latest).to include(products[7])
        expect(latest).to include(products[6])
        expect(latest).to include(products[5])

        expect(latest).to_not include(products[4])
        expect(latest).to_not include(products[3])
        expect(latest).to_not include(products[2])
        expect(latest).to_not include(products[1])
        expect(latest).to_not include(products[0])
      end

      it "lists newest record at the very top" do
        expect(Product.latest.first).to eql(products[9])
        expect(Product.latest.last).to eql(products[5])
      end
    end

    describe "#most_recent" do
      let!(:products) { create_list(:product, 3) }

      it "return the most recent products" do
        expect(Product.most_recent.count).to eql(Product.count)
      end

      it "list the most recent" do
        most_recent = Product.most_recent

        expect(most_recent).to include(products[2])
        expect(most_recent).to include(products[1])
        expect(most_recent).to include(products[0])
      end

      it "list the latest updated at the very top" do

        expect(Product.most_recent.first).to eql(products[2])
        expect(Product.most_recent.last).to eql(products[0])

        products[0].updated_at = Time.now
        products[0].save!

        expect(Product.most_recent.first).to eql(products[0])
        expect(Product.most_recent.first).to_not eql(products[2])

        expect(Product.most_recent.last).to eql(products[1])
        expect(Product.most_recent.last).to_not eql(products[0])
      end
    end

  end
end
