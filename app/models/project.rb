class Project < ApplicationRecord
  # belongs_to :user
  has_many :project_users
  has_many :users, through: :project_users

  has_many :bugs

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'



  validates :title, presence: true, length: {minimum: 3, maximum: 30}
  validates :description, presence: true, length: {minimum: 5, maximum: 400}

  
end




# p = project.find(1)
# puts p.users
# p.creator #all the data of creator
