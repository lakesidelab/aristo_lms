class CreateAristoLmsAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :aristo_lms_answers do |t|
      t.integer :user_id
      t.integer :attempt_id
      t.integer :question_id
      t.string :multiple_answer_ids
      t.integer :answer_id

      t.timestamps
    end
  end
end
