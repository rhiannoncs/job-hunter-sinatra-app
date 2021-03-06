class Skill < ActiveRecord::Base
	validates_presence_of :name
	validates_uniqueness_of :name
	has_many :skill_postings
	has_many :postings, through: :skill_postings
	has_many :companies, through: :postings
end