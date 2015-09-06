class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :content, null: false
      t.integer :width
      t.integer :height
      t.float :ratio
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
