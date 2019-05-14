class ReadAloudChart < ApplicationRecord
  validates :rate, presence: true
  belongs_to :users, optional: true
end
