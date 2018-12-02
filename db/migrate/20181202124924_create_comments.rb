class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :task_id, null: false, references: :tasks
      t.integer :user_id, null: false, references: :users

      t.timestamps
    end
  end
end
