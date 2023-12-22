class Project < ApplicationRecord
  belongs_to :user
  has_many :bugs



  validates :title, presence: true, length: {minimum: 3, maximum: 30}
    validates :description, presence: true, length: {minimum: 5, maximum: 400}

  
end
