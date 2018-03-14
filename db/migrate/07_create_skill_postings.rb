class CreateSkillPostings < ActiveRecord::Migration[5.1]
	def change
		create_table :skillpostings do |t|
			t.integer :skill_id
			t.integer :posting_id
		end
	end
end