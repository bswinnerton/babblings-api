require 'app/uploaders/image_uploader'

class Image < ActiveRecord::Base
  include GraphQLable

  mount_uploader :source, ImageUploader
  acts_as_paranoid

  default_scope { order(created_at: :desc) }

  def reprocess!
    update!(remote_source_url: origin, processing: false)
  end

  def content
    source.url || placeholder
  end

  def placeholder
    "http://placehold.it/#{width || 300}x#{height || 300}.png"
  end
end
