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
			actions = Action.all.select {|action| action.user == @user}
			@recent_actions = actions.last(10).reverse
			postings = Posting.all.select {|posting| posting.user == @user}
			@recent_postings = postings.last(5).reverse
			companies = Company.all.select {|company| company.user == @user}
			@recent_companies = companies.last(5).reverse
			erb :'/users/dashboard'
		else
			redirect to "/login"
		end
	end

	get '/users/:id/postings' do
		@user = User.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif @user == current_user
			all_postings = Posting.all.select {|posting| posting.user == @user}
			@postings = all_postings.reverse
			erb :'/users/postings'
		else
			redirect to "/users/#{current_user.id}/postings"
		end
	end

	get '/users/:id/companies' do
		@user = User.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif @user == current_user
			all_companies = Company.all.select {|company| company.user == @user}
			@companies = all_companies.reverse
			erb :'/users/companies'
		else
			redirect to "/users/#{current_user.id}/companies"
		end
	end

	get '/users/:id/actions' do
		@user = User.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif @user == current_user
			all_actions = Action.all.select {|action| action.user == @user}
			@actions = all_actions.reverse
			erb :'/users/actions'
		else
			redirect to "/users/#{current_user.id}/actions"
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