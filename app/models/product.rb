class Product < ActiveRecord::Base

  before_create :set_publish_date

  belongs_to :user
  belongs_to :company

  has_attached_file :image,
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "missing.png"

  validates_attachment_size :image,
    less_than: 5.megabytes

  validates_attachment_content_type :image,
    content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :name, :description, :image, presence: true

  scope :most_recent, -> { order( updated_at: :desc, created_at: :desc ) }
  scope :latest,      -> { order( created_at: :desc ).limit(5)           }

  def set_publish_date
    self.published_ad = Time.now
  end

end
