class Project < ApplicationRecord
  # belongs_to :user
  has_many :project_users
  has_many :users, through: :project_users
  has_many :bugs, dependent: :destroy
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  validates :title, presence: true, length: {minimum: 3, maximum: 30}
  validates :description, presence: true, length: {minimum: 5, maximum: 400}

  before_create :check_user_type

  private

  def check_user_type
    unless creator.manager?
      errors.add(:base, 'Project can only be created by a manager, not someone like you')
      throw(:abort)
    end
  end
end
