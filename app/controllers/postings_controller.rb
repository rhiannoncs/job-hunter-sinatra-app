class PostingsController < ApplicationController

	get '/postings/new' do
		if logged_in?
			erb :"/postings/new"
		else
			redirect to "/login"
		end
	end

	post '/postings/new' do
		params.delete(:captures) if params.key?(:captures) && params[:captures].empty?
		posting = Posting.create(params["posting"])

		if posting.save
			posting.update(user_id: current_user.id)
			if params["skill"][:name].length > 0
				skill = Skill.create(name: params[:skill][:name])
				posting.skills << skill
				posting.save
			end
			redirect to "/postings/#{posting.id}"
		else
			flash[:message] = "Job title, posting content and company are required fields."
			redirect to "/postings/new"
		end
	end

	get '/postings/:id' do
		@posting = Posting.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif !@posting
			redirect to "/users/#{current_user.id}"
		else
			binding.pry
			erb :"/postings/show"
		end
	end


end