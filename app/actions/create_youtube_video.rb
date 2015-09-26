class CreateYoutubeVideo
  attr_reader :existing_video, :source, :youtube_id

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
    @existing_video ||= YoutubeVideo.find_by(youtube_id: youtube_id)
  end

  def create_video
    YoutubeVideo.create!(source: source, youtube_id: youtube_id)
  end

  private

  def youtube_id
    @youtube_id ||= YoutubeLink.new(source).id
  end
end
