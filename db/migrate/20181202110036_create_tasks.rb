class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string  :name
      t.integer :priority, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.date    :deadline
      t.integer :project_id, null: false, references: :projects

      t.timestamps
    end
  end
end
