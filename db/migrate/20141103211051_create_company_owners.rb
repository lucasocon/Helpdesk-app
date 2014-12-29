class CreateCompanyOwners < ActiveRecord::Migration
  def change
    create_table :company_owners, id: false do |t|
      t.belongs_to :company
      t.belongs_to :user
    end
  end
end
