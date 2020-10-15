class CreateAristoLmsAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :aristo_lms_attempts do |t|
      t.integer :user_id
      t.integer :subscription_id
      t.string :current_node_id
      t.integer :total_question
      t.integer :score, default: 0
      t.integer :completed
      t.integer :result

      t.timestamps
    end
  end
end
