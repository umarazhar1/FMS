class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :folders, dependent: :destroy

  validates :name, presence: true
  validates :user_type, presence: true

  enum user_type: { admin: 0, simple_user: 1 }
end
