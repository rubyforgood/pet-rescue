class Donation < ApplicationRecord
	validates :amount, presence: true
	validates :currency, presence: true
end
