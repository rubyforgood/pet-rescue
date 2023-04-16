class DonationsController < ApplicationController
	def create
		@mapped_response = PaypalResponseMapper.new(params) if params[:source] == 'Paypal'
		
		if @mapped_response
		  @donation = Donation.new(@mapped_response.map)
      @donation.save! if @donation.valid?
		end
	end
end
