require "spec_helper"

describe AccountManager do
  let(:user_attrs)    { attributes_for(:user) }
  let(:company_attrs) { attributes_for(:company) }

  describe "Validations" do
    it "requires company_name to be unique" do
      existing_company = create(:company)

      subject.company_name = existing_company.name
      expect(subject).not_to be_valid
      expect(subject).to have_at_least(1).errors_on(:company_name)
    end

    it "requires email to be unique" do
      existing_user = create(:user)

      subject.email = existing_user.email
      expect(subject).not_to be_valid
      expect(subject).to have_at_least(1).errors_on(:email)
    end
  end

  describe "#save" do
    context "with valid data" do
      before(:each) do
        @manager = AccountManager.new(
          company_name: company_attrs[:name],
          email: user_attrs[:email],
          password: user_attrs[:password]
        )

        @manager.save
      end

      it "creates a valid user" do
        expect(User.where(email: user_attrs[:email])).not_to be_empty
      end

      it "creates an unconfirmed user" do
        expect(User.last).not_to be_confirmed
      end

      it "creates a valid company" do
        expect(Company.where(name: company_attrs[:name])).not_to be_empty
      end

      it "registers the user as a company owner" do
        user = User.last
        company = Company.last

        expect(company.owners).to include(user)
      end

      it "registers the user as a company member" do
        user = User.last
        company = Company.last

        expect(company.members).to include(user)
      end
    end

    context "with invalid data" do
      before(:each) do
        @manager = AccountManager.new

        @manager.save
      end

      it "doesn't create an account" do
        expect(User.count).to eql(0)
        expect(Company.count).to eql(0)
      end
    end
  end
end
