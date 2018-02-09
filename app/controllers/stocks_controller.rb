class StocksController < ApplicationController
	def search
		if params[:stock].blank?
			flash.now[:danger] = "You haven't entered search text."
		else
			@stock = Stock.new_from_lookup(params[:stock])
			flash.now[:danger] = "Searched Term is not there." unless @stock
		end
		respond_to do |format|
			format.js { render partial: 'users/result' }
		end
	end
end