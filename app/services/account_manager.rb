class AccountManager
  include Virtus.model
  include ActiveModel::Model

  attribute :company_name, String
  attribute :email,        String
  attribute :password,     String

  validates :company_name, :email, :password, presence: true
  validate  :available_company_name
  validate  :available_email_account

  def save
    valid? ? persist! : false
  end

protected
  def persist!
    return false unless user && company

    company.owners  << user
    company.members << user
    company.save

    true
  end

  def company
    @company ||= Company.create(name: company_name)
  end

  def user
    @user ||= User.create(email: email,
      password: password, password_confirmation: password)
  end

  def available_company_name
    unless Company.where(name: company_name).count == 0
      errors.add(:company_name, "has already been taken")
    end
  end

  def available_email_account
    unless User.where(email: email).count == 0
      errors.add(:email, "has already been taken")
    end
  end
end
