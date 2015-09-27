class VimeoVideo < ActiveRecord::Base
  acts_as_paranoid

  default_scope { order(created_at: :desc) }

  validates :source, presence: true

  def content
    "https://player.vimeo.com/video/#{vimeo_id}?portrait=0&byline=0&title=0"
  end
end
