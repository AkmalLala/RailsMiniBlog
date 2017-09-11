class Comment < ApplicationRecord
  # before_create :default_status
  belongs_to :article
  validates :author, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  # def default_status
  #   self.status = "not active"
  # end
end
