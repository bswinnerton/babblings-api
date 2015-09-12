class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :source
      t.text :origin
      t.integer :width
      t.integer :height
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
