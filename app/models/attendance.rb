class Attendance < ApplicationRecord
  belongs_to :event

  validates :user_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, presence: true, format: { with: /\A\+\d{1,3}\s?\d{1,14}\z/ }
end
