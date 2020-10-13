class CreateAristoLmsTrainingHierarchies < ActiveRecord::Migration[6.0]
  def change
    create_table :aristo_lms_training_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :aristo_lms_training_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "training_anc_desc_idx"

    add_index :aristo_lms_training_hierarchies, [:descendant_id],
      name: "training_desc_idx"
  end
end
