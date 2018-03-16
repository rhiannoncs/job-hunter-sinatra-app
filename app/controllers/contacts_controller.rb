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
			flash[:message] = "Name and company are required fields."
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

end