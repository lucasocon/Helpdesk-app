require "spec_helper"

feature "Creating a new Product" do
  let(:account_1) { new_account }
  let(:account_2) { new_account( owner: false) }

  scenario "Creates a product as owner" do
    company, user = account_1

    sign_in user

    expect(current_path).to eql("/#{company.slug}")

    click_link('New Product')

    expect(page).to have_content("New Product")

    fill_in "product[name]",        with: "Bugs Bunny"
    fill_in "product[description]", with: "The white rabbit"
    attach_file('Image', "#{Rails.root}/spec/factories/images/g.jpg")

    click_button "Create Product"

    expect(Product.where(name: "Bugs Bunny")).not_to be_empty
    latest_product = Product.last
    expect(User.count).to eql(1)
  end

  scenario "Fails at create new product as member" do
    otro_company, otro_user = account_2

    sign_in otro_user

    expect(page).not_to have_content("New Product")
  end
end
