class DonationsController
	class PaypalResponseMapper
		
		def initialize(params)
			@amount = params[:amt]
			@currency = params[:cc]
			@status = params [:st]
		end

		def transaction_successful?
			@status == 'Completed'
		end

		def map
			return nil if !transaction_successful?

				{
					amount: @amount, 
					currency: @currency
				}
		end
	end
end
