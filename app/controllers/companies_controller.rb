class CompaniesController < ApplicationController

	get '/companies/new' do
		if logged_in?
			erb :"/companies/new"
		else
			redirect to "/login"
		end
	end

	post '/companies/new' do
		params.delete(:captures) if params.key?(:captures) && params[:captures].empty?
		company = Company.create(params)

		if company.save
			redirect to "/companies/#{company.id}"
		else
			flash[:message] = "Name is a required field."
			redirect to "/companies/new"
		end
	end
end