class CreateCompanies < ActiveRecord::Migration[5.1]
	def change
		create_table :companies do |t|
			t.string :name
			t.string :location
			t.string :website
			t.integer :user_id
		end
	end
end