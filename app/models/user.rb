class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable

  has_many :products

  has_and_belongs_to_many :owned_companies,
    class_name: "Company",
    join_table: "company_owners",
    foreign_key: "company_id",
    association_foreign_key: "user_id"

  has_and_belongs_to_many :joined_companies,
    class_name: "Company",
    join_table: "company_members",
    foreign_key: "company_id",
    association_foreign_key: "user_id"

end
