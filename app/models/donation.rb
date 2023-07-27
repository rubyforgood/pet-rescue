# == Schema Information
#
# Table name: donations
#
#  id         :bigint           not null, primary key
#  amount     :string
#  currency   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Donation < ApplicationRecord
	validates :amount, presence: true
	validates :currency, presence: true

  def self.sum_donations_by_currency
    Donation.all.reduce({}) do |sums, transaction|
      amount = transaction[:amount].to_f
      currency = transaction[:currency]

      if sums.key?(currency)
        sums[currency] += amount
      else
        sums[currency] = amount
      end
      sums
    end
  end
end
