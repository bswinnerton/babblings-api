require 'carrierwave/orm/activerecord'

class Image < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  mount_uploader :source, ImageUploader

  def content
    source.current_path
  end
end
