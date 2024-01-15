class Qr < ApplicationRecord
  has_one_attached :qr_code_image
  has_many :qrs, dependent: :destroy
  belongs_to :folder
  belongs_to :user

  validates_uniqueness_of :name
  validates :name, presence: true

  before_create :user_should_present

  private

  def user_should_present
    unless user.present?
      errors.add(:base, 'Project can only be created by a manager, not someone like you')
      throw(:abort)
    end
  end
end


