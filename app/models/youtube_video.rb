class YoutubeVideo < ActiveRecord::Base
  acts_as_paranoid

  default_scope { order(created_at: :desc) }

  validates :source, presence: true

  def content
    "http://www.youtube.com/embed/#{youtube_id}?showinfo=0&controls=0"
  end
end
