require "test_helper"

class DonationTest < ActiveSupport::TestCase
  context "validations" do
    should validate_presence_of(:amount)
    should validate_presence_of(:currency)
  end

  def test_sum_donations_by_currency
    Donation.create!(amount: "5", currency: "biscuits")
    Donation.create!(amount: "2", currency: "biscuits")
    Donation.create!(amount: "10", currency: "treats")
    expected = {"biscuits" => 7, "treats" => 10}

    assert_equal Donation.sum_donations_by_currency, expected
  end
end
