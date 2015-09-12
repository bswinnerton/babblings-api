require 'carrierwave/orm/activerecord'

class Image < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  mount_uploader :source, ImageUploader
  acts_as_paranoid

  def content
    source.current_path
  end
end
