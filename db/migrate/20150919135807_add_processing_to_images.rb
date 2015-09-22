class AddProcessingToImages < ActiveRecord::Migration
  def change
    add_column :images, :processing, :boolean, default: false, null: false
  end
end
