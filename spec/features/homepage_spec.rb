require "spec_helper"

feature "Homepage" do
  let(:account) { new_account }

  scenario "visited by any given internet user" do
    visit "/"

    expect(page).to have_content("HelpDesk App")
    expect(page).to have_content("You're most welcome!")
  end

  scenario "visited by an active company member" do
    company, user = new_account

    sign_in user

    visit "/"

    expect(current_path).to eql("/#{company.slug}")
  end
end
