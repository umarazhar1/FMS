class Qr < ApplicationRecord
  has_one_attached :qr_code_image
  has_many :qrs, dependent: :destroy
  belongs_to :folder

  validates_uniqueness_of :name
  validates :name, presence: true
end


