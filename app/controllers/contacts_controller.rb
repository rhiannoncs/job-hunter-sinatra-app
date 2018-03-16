class ContactsController < ApplicationController

	get '/contacts/new' do
		if logged_in?
			erb :"/contacts/new"
		else
			redirect to "/login"
		end
	end

	post '/contacts/new' do
		params.delete(:captures) if params.key?(:captures) && params[:captures].empty?
		contact = Contact.create(params)

		if contact.save
			contact.update(user_id: current_user.id)
			redirect to "/contacts/#{contact.id}"
		else
			flash[:message] = "Name is a required field."
			redirect to "/contacts/new"
		end
	end

	get '/contacts/:id' do
		@contact = Contact.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif !@contact
			redirect to "/users/#{current_user.id}"
		else
			erb :"/contacts/show"
		end
	end

	get '/contacts/:id/edit' do
		@contact = Contact.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif @contact && @contact.user == current_user
			erb :"/contacts/edit"
		else
			redirect to "/users/#{current_user.id}"
		end
	end

	patch '/contacts/:id' do
		contact = Contact.find_by(:id => params[:id])
		params.delete(:captures) if params.key?(:captures) && params[:captures].empty?
		if contact.update(:name => params[:name], :title => params[:title], :phone => params[:phone], 
			:email => params[:email], :linkedin => params[:linkedin], :company_id => params[:company_id])
			redirect to "/contacts/#{contact.id}"
		else
			flash[:message] = "Name is a required field."
			redirect to "/contacts/#{contact.id}/edit"
		end
	end

	delete '/contacts/:id/delete' do
		@contact = Contact.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif @contact.user == current_user
			@contact.delete
			flash[:message] = "Contact has been deleted."
			redirect to "/users/#{current_user.id}"
		else
			redirect to "/users/#{current_user.id}"
		end
	end

end