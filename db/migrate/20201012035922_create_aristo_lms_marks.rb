class CreateAristoLmsMarks < ActiveRecord::Migration[6.0]
  def change
    create_table :aristo_lms_marks do |t|
      t.integer :training_id
      t.integer :user_id
      t.integer :marks
      
      t.timestamps
    end
  end
end
