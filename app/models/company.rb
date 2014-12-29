class Company < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true

  has_many :products

  has_and_belongs_to_many :owners,
    class_name: "User",
    join_table: "company_owners",
    foreign_key: "user_id",
    association_foreign_key: "company_id"

  has_and_belongs_to_many :members,
    class_name: "User",
    join_table: "company_members",
    foreign_key: "user_id",
    association_foreign_key: "company_id"

  def owned_by(user_id)
    owners.where(id: user_id).size != 0
  end
end
