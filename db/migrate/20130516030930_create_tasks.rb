class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :description
      t.integer :status
      t.references :story

      t.timestamps
    end
    add_index :tasks, :story_id
  end
end
