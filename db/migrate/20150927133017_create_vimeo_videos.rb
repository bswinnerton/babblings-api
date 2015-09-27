class CreateVimeoVideos < ActiveRecord::Migration
  def change
    create_table :vimeo_videos do |t|
      t.text :source, null: false
      t.text :vimeo_id
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :vimeo_videos, :deleted_at
  end
end
