class Project < ApplicationRecord
  # belongs_to :user
  has_many :project_users
  has_many :users, through: :project_users

  has_many :bugs




  validates :title, presence: true, length: {minimum: 3, maximum: 30}
    validates :description, presence: true, length: {minimum: 5, maximum: 400}

  
end
