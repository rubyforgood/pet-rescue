class DonationsController < ApplicationController
	def create
		@mapped_response = PaypalResponseMapper.new(params) if params[:source] == 'Paypal'
		
		if @mapped_response
		  @donation = Donation.create!(@mapped_response.map)
		end
	end
end
