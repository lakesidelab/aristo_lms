class CreateAristoLmsStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :aristo_lms_statuses do |t|
      t.integer :subscription_id
      t.integer :active_module_id
      t.integer :active_node_id
      t.integer :user_id

      t.timestamps
    end
  end
end
