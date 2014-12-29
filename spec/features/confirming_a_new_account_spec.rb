require "spec_helper"

feature "Confirming a new Account" do
  let!(:user) { create(:user) }

  scenario "with an existing token" do
    open_email user.email

    current_email.click_link "Confirm my account"

    expect(user.reload).to be_confirmed

    expect(current_path).to eql(new_user_session_path)
    expect(page).to have_content("Your email address has been successfully confirmed.")
  end
end
