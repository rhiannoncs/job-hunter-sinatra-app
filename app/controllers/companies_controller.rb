class CompaniesController < ApplicationController

	get '/companies' do
		if logged_in?
			@companies = Company.order(:name)
			erb :"/companies/show_all"
		else
			redirect to "/login"
		end
	end

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

	get '/companies/:id' do
		@company = Company.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif !@company
			redirect to "/users/#{current_user.id}"
		else
			@contacts = Contact.all.select {|contact| contact.company == @company}
			@postings = Posting.all.select {|posting| posting.company == @company}
			@skills = Skill.all.select {|skill| skill.companies.include?(@company)}
			erb :"/companies/show"
		end
	end

	get '/companies/:id/edit' do
		@company = Company.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif @company && @company.user == current_user
			erb :"/companies/edit"
		else
			redirect to "/users/#{current_user.id}"
		end
	end

	patch '/companies/:id' do
		company = Company.find_by(:id => params[:id])
		params.delete(:captures) if params.key?(:captures) && params[:captures].empty?
		if company.update(:name => params[:name], :location => params[:location], :website => params[:website])
			redirect to "/companies/#{company.id}"
		else
			flash[:message] = "Name is a required field."
			redirect to "/companies/#{company.id}/edit"
		end
	end

	delete '/companies/:id/delete' do
		@company = Company.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif @company.user == current_user
			@company.delete
			flash[:message] = "Company has been deleted."
			redirect to "/users/#{current_user.id}"
		else
			redirect to "/users/#{current_user.id}"
		end
	end
end