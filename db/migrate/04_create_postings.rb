class CreatePostings < ActiveRecord::Migration[5.1]
	def change
		create_table :postings do |t|
			t.string :content
			t.string :url
			t.string :status
			t.string :location
			t.string :remote_availability
			t.integer :company_id
			t.integer :user_id
		end
	end
end