class CreateRepositories < ActiveRecord::Migration[5.0]
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :owner
      t.integer :stargazer_count
      t.integer :fork_count
      t.integer :since_last_commit
      t.references :hierarchy, index: true, foreign_key: true

      t.timestamps
    end
    add_index :repositories, [:hierarchy_id, :name, :owner]
  end
end
