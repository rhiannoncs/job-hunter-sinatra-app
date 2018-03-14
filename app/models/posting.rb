class Posting < ActiveRecord::Base
	validates_presence_of :content
	has_many :skills
	belongs_to :company
	belongs_to :user
end