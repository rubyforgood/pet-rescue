class DonationsController < ApplicationController
	def create
		@mapped_response = PaypalResponseMapper.new(params) if params[:source] == 'Paypal'
		
		@donation = Donation.create!(@mapped_response.map)
	end
end
