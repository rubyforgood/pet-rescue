require "test_helper"

class DonationFlowTest < ActionDispatch::IntegrationTest
    
  setup do
		@completed_paypal_response = {
			amt: "3.00",
			cc: "CAD",
			cm: "",
			item_name: "",
			source: "Paypal",
			st: "Completed",
			tx: "1XK90052WY2336533"
		}

		@failed_paypal_response = {
			amt: "3.00",
			cc: "CAD",
			cm: "",
			item_name: "",
			source: "Paypal",
			st: "Not Completed",
			tx: "1XK90052WY2336533"
		}
	end
	
	test "post request with completed status creates a new donation record " do 
		donation_count_before = Donation.all.length

		post '/donations', 
			params: @completed_paypal_response
		
		donation_count_after = Donation.all.length
		assert_equal donation_count_after, donation_count_before + 1
		
		assert_equal Donation.last["amount"], "3.00"
		assert_equal Donation.last["currency"], "CAD"
		
	end

	test "post request with failed status does not create a new donation record" do
    donation_count_before = Donation.all.length

    post '/donations', 
			params: @failed_paypal_response
		
		donation_count_after = Donation.all.length
		assert_equal donation_count_after, donation_count_before
	end
end
