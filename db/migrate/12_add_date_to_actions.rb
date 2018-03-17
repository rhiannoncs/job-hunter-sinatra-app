class AddDateToActions < ActiveRecord::Migration[5.1]
	def change
		add_column :actions, :date, :date
	end
end