class Qr < ApplicationRecord
  has_one_attached :qr_code_image
  belongs_to :folder, optional: true
  belongs_to :user

  validates_uniqueness_of :name
  validates :name, presence: true

  before_create :user_should_present

  private

  def user_should_present
    unless user.present?
      errors.add(:base, 'A QR code cannot be created without any user. Somebody must be there to create the QR code..... COMMON SENSE!')
      throw(:abort)
    end
  end
end


