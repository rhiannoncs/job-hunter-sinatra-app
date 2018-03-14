class Company < ActiveRecord::Base
	validates_presence_of :name
	has_many :postings
	has_many :contacts
	has_many :actions
	has_many :skills, through: :postings
	belongs_to :user
end