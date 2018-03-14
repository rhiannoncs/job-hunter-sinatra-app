class CreateContacts < ActiveRecord::Migration[5.1]
	def change
		create_table :contacts do |t|
			t.string :name
			t.string :email
			t.string :phone
			t.string :title
			t.integer :company_id
			t.integer :user_id
		end
	end
end