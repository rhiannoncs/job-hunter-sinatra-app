class UsersController < ApplicationController

	get '/signup' do
		erb :'/users/signup'
	end

	post '/signup' do
		params.delete(:captures) if params.key?(:captures) && params[:captures].empty?
		user = User.create(params)
		if user.save
			session[:user_id] = user.id
			redirect to "/users/#{user.id}"
		else
			flash[:message] = "Account could not be created. Verify all fields are complete and username and email have not previously been used."
			redirect to "/signup"
		end
	end

	get '/users/:id' do
		@user = User.find_by(:id => params[:id])
		if @user == current_user
			#@recent_actions = Action.find
			#@recent_postings = Posting.all.select {|posting| posting.user_id == @user.id}
			#@recent_companies = Company.all.select {|company| company.user_id == @user.id}
			erb :'/users/dashboard'
		else
			redirect to "/login"
		end
	end

	get '/login' do
		if !logged_in?
			erb :'/users/login'
		else
			redirect to "/users/#{current_user.id}"
		end
	end

	post '/login' do
		user = User.find_by(:username => params[:username])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect to "/users/#{user.id}"
		else
			flash[:message] = "Login failed. Verify your username and password are correct."
			redirect to "/login"
		end
	end

	get '/logout' do
		if logged_in?
			session.clear
			redirect to "/login"
		else
			redirect to "/login"
		end
	end
end