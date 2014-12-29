require "spec_helper"

feature "Dashboard Login" do
  let(:account_1) { new_account }
  let(:account_2) { new_account( owner: false) }

  scenario "loging in with an owner" do
    company, user = account_1

    sign_in user

    expect(current_path).to eql("/#{company.slug}")
  end

  scenario "logging in with a member" do
    company, user = account_2

    sign_in user

    expect(current_path).to eql("/#{company.slug}")
  end

  scenario "logging in with an unauthorized user" do
    company, user  = account_1
    some, stranger = account_2

    sign_in stranger

    visit "/#{company.slug}"

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
