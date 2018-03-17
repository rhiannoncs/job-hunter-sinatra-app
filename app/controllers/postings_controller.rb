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
			flash[:message] = "Job title, posting content and company are required fields. If creating a skill, name is a required field."
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
			erb :"/postings/show"
		end
	end

	get '/postings/:id/edit' do
		@posting = Posting.find_by(:id => params[:id])
		if !logged_in?
			redirect to "/login"
		elsif @posting && @posting.user == current_user
			erb :"/postings/edit"
		else
			redirect to "/users/#{current_user.id}"
		end
	end

	patch '/postings/:id' do
		posting = Posting.find_by(:id => params[:id])
		params.delete(:captures) if params.key?(:captures) && params[:captures].empty?
		
		if posting.update(:job_title => params[:posting][:job_title], :company_id => params[:posting][:company_id], :content => params[:posting][:content], 
			:url => params[:posting][:url], :location => params[:posting][:location], :status => params[:posting][:status], :remote_availability => params[:posting][:remote_availability],
			:skill_ids => params[:posting][:skill_ids])
			if params["skill"][:name].length > 0
				skill = Skill.create(name: params[:skill][:name])
				posting.skill_postings.create(skill_id: skill.id)
				posting.save
			end
			redirect to "/postings/#{posting.id}"
		else
			flash[:message] = "Job posting, title, and content are required fields. If creating a skill, name is a required field."
			redirect to "/postings/#{posting.id}/edit"
		end
	end


end