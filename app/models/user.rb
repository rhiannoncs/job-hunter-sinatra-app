class User < ActiveRecord::Base
	validates_presence_of :username
	validates_presence_of :email
	has_secure_password
	has_many :actions
	has_many :companies
	has_many :postings
	has_many :contacts
end