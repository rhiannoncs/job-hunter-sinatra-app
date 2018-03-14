class Contact < ActiveRecord::Base
	validates_presence_of :name
	belongs_to :company
	belongs_to :user
end