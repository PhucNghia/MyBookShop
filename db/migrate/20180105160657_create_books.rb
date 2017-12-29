class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :picture
      t.float :price
      t.boolean :status
      t.integer :category_id
      t.integer :publisher_id

      t.timestamps
    end
  end
end
