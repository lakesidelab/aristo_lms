class CreateAristoLmsSwitches < ActiveRecord::Migration[6.0]
  def change
    create_table :aristo_lms_switches do |t|
      t.integer :attempt_id
      t.integer :training_id
      t.boolean :completed

      t.timestamps
    end
  end
end
