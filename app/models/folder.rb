class Folder < ApplicationRecord
  belongs_to :user, required: true
  has_many :qrs

  before_create :user_should_present

  private

  def user_should_present
    unless user.present?
      errors.add(:base, 'Project can only be created by a manager, not someone like you')
      throw(:abort)
    end
  end

end

