class CreateAristoLmsTrainings < ActiveRecord::Migration[6.0]
  def change
    create_table :aristo_lms_trainings do |t|
      t.string :name
      t.text :description
      t.integer :position
      t.text :content
      t.string :category
      t.string :correct
      t.integer :user_id
      t.integer :parent_id
      t.integer :sort_order

      t.timestamps
    end
  end
end
