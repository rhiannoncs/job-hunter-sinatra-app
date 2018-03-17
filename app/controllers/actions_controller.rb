class ActionsController < ApplicationController

	get '/actions/new' do
		if logged_in?
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
		elsif !@action
			redirect to "/users/#{current_user.id}"
		else
			erb :"/actions/show"
		end
	end

end