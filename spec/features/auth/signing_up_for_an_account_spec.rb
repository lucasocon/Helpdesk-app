require "spec_helper"

feature "Signing up for an Account" do

  background do
    visit signup_path
  end

  scenario "with valid data" do
    fill_in "account_manager[company_name]", with: "Stark Inc."
    fill_in "account_manager[email]",        with: "tony@stark.com"
    fill_in "account_manager[password]",     with: "123123123"

    click_button "Sign up"

    expect(User.where(email: "tony@stark.com")).not_to be_empty
    expect(last_email.to).to include("tony@stark.com")

    latest_company = Company.last
    latest_user    = User.last
    expect(latest_company.owners).to include(latest_user)
    expect(latest_company.members).to include(latest_user)

    expect(current_path).to eql(root_path)
    expect(page).to have_content("You're almost there. Now, you'll need to confirm your email")
  end

  scenario "with invalid data" do
    click_button "Sign up"

    expect(User.count).to eql(0)
    expect(Company.count).to eql(0)


    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  scenario "with an existing email account" do
    existing_user = create(:user)

    fill_in "account_manager[company_name]", with: "Stark Inc."
    fill_in "account_manager[email]",        with: existing_user.email
    fill_in "account_manager[password]",     with: "123123123"

    click_button "Sign up"

    expect(User.where(email: existing_user.email).count).to eql(1)
    expect(Company.count).to eql(0)

    expect(page).to have_content("Email has already been taken")
  end

  scenario "with an existing company name" do
    existing_company = create(:company)

    fill_in "account_manager[company_name]", with: existing_company.name
    fill_in "account_manager[email]",        with: "tony@stark.com"
    fill_in "account_manager[password]",     with: "123123123"

    click_button "Sign up"

    expect(User.count).to eql(0)
    expect(Company.where(name: existing_company.name).count).to eql(1)

    expect(page).to have_content("Company name has already been taken")
  end

end
