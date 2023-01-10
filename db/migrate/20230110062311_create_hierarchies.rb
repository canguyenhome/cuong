class CreateHierarchies < ActiveRecord::Migration[5.0]
  def change
    create_table :hierarchies do |t|
      t.references :technology, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
