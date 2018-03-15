class Posting < ActiveRecord::Base
	validates_presence_of :content
	validates_presence_of :job_title
	has_many :skills, through: :skill_postings
	belongs_to :company
	belongs_to :user
end