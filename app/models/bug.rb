class Bug < ApplicationRecord
  belongs_to :project
  has_many :bug_users, dependent: :destroy
  has_many :users, through: :bug_users, dependent: :destroy
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  validates :title, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :title
  validates :title, :status, :bug_type, presence: true
  validate :validate_images

  enum bug_type: { bug: 0, feature: 1 }
  enum status: { new_bug: 0, started: 1, resolved: 2, completed: 3 }

  has_many_attached :images
  before_create :check_user_type

  private

  def check_user_type
    unless creator.qa?
      errors.add(:base, 'Bug can only be created by a QA, not someone like you')
      throw(:abort)
    end
  end
  
  def validate_images
    return unless images.attached?
    images.each do |image|
      unless image.content_type.in?(%w[image/png image/gif])
        errors.add(:images, 'must be a PNG or GIF')
      end

      unless image.byte_size <= 5.megabytes
        errors.add(:images, 'size cannot exceed 5MB')
      end
    end
  end
end
