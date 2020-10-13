class CreateAristoLmsSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :aristo_lms_subscriptions do |t|
      t.string :training_id
      t.string :user_id

      t.timestamps
    end
  end
end
