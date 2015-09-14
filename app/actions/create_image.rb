class CreateImage
  def self.perform(params)
    new(url: params[:url]).perform
  end

  def initialize(url:)
    @url = url
  end

  def perform
    Image.find_or_create_by!(origin: url) { |i| i.remote_source_url = url }
  end

  private

  attr_reader :url
end
