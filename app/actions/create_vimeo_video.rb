class CreateVimeoVideo
  attr_reader :existing_video, :source, :vimeo_id

  def self.perform(params)
    new(source: params[:source]).perform
  end

  def initialize(source:)
    @source = source
  end

  def perform
    return existing_video if existing_video?
    create_video
  end

  def existing_video?
    @existing_video ||= VimeoVideo.find_by(vimeo_id: vimeo_id)
  end

  def create_video
    VimeoVideo.create!(source: source, vimeo_id: vimeo_id)
  end

  private

  def vimeo_id
    @vimeo_id ||= VimeoLink.new(source).id
  end
end
