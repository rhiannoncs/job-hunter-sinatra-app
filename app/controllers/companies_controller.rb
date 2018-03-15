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
			company.update(user_id: current_user.id)
			redirect to "/companies/#{company.id}"
		else
			flash[:message] = "Name is a required field."
			redirect to "/companies/new"
		end
	end

	get "/companies/:id" do
		if logged_in?
			@company = Company.find_by(:id => params[:id])
			@contacts = Contact.all.select {|contact| contact.company == @company}
			@postings = Posting.all.select {|posting| posting.company == @company}
			@skills = Skill.all.select {|skill| skill.company == @company}
			erb :"/companies/show"
		else
			redirect to "/login"
		end
	end
end