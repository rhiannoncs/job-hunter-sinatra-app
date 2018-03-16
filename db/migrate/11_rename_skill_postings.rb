class RenameSkillPostings < ActiveRecord::Migration[5.1]
	def change
		rename_table :skillpostings, :skill_postings
	end
end