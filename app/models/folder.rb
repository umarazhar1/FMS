class Folder < ApplicationRecord
  belongs_to :user, required: true
  has_many :qrs
end

