class AddJobTitleToPostings < ActiveRecord::Migration[5.1]
	def change
		add_column :postings, :job_title, :string
	end
end