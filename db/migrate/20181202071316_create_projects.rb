class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string  :name
      t.integer :user_id, null: false, references: :users

      t.timestamps
    end
  end
end
