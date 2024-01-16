class Folder < ApplicationRecord
  belongs_to :user#, required: true
  has_many :qrs, dependent: :destroy

  before_create :user_should_present

  private

  def user_should_present
    unless user.present?
      errors.add(:base, 'A folder cannot be created without any user. Somebody must be there to create the folder..... COMMON SENSE!')
      throw(:abort)
    end
  end
end

