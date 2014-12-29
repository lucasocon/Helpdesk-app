module UsefulHelpers
  def last_email
    ActionMailer::Base.deliveries.last
  end

  def new_account(options = { owner: true })
    company = create(:company)
    user    = create(:user, :confirmed)

    company.owners  << user if options[:owner]
    company.members << user

    [company, user]
  end

  def sign_in(user)
    visit new_user_session_path

    fill_in "user[email]",    with: user.email
    fill_in "user[password]", with: user.password

    click_button "Log in"
  end
end
