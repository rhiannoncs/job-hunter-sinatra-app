class AddLinkedinToContacts < ActiveRecord::Migration[5.1]
	def change
		add_column :contacts, :linkedin, :string
	end
end