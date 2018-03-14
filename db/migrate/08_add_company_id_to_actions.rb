class AddCompanyIdToActions < ActiveRecord::Migration[5.1]
	def change
		add_column :actions, :company_id, :integer
	end
end