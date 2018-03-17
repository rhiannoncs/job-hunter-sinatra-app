class ActionsController < ApplicationController

	get '/actions/new' do
		if logged_in?
			@action_types = ["Application", "Contact", "Other"]
			erb :"/actions/new"
		else
			redirect to "/login"
		end
	end

	post '/actions/new' do
		params.delete(:captures) if params.key?(:captures) && params[:captures].empty?
		action = Action.create(params)

		if action.save
			action.update(user_id: current_user.id)
			redirect to "/actions/#{action.id}"
		else
			flash[:message] = "Action could not be saved."
			redirect to "/actions/new"
		end
	end

	get '/actions/:id' do
		@action = Action.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif @action && @action.user == current_user
			erb :"/actions/show"
		else
			redirect to "/users/#{current_user.id}"
		end
	end

	get '/actions/:id/edit' do
		@action = Action.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif @action && @action.user == current_user
			@action_types = ["Application", "Contact", "Other"]
			erb :"/actions/edit"
		else
			redirect to "/users/#{current_user.id}"
		end
	end

end