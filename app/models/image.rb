class Image < ActiveRecord::Base
  mount_uploader :source, ImageUploader
  acts_as_paranoid

  default_scope { order(created_at: :desc) }

  def content
    source.url || placeholder
  end

  def placeholder
    "http://placehold.it/#{width || 300}x#{height || 300}.png"
  end
end
