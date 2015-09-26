class CreateYoutubeVideos < ActiveRecord::Migration
  def change
    create_table :youtube_videos do |t|
      t.text :source, null: false
      t.text :youtube_id
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :youtube_videos, :deleted_at
  end
end
