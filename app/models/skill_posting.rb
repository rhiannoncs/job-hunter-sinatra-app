class SkillPosting < ActiveRecord::Base
	belongs_to :skill
	belongs_to :posting
end