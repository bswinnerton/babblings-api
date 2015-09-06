class CreateImage
  def self.perform(params)
    new(content: params[:content]).perform
  end

  def initialize(content:)
    @content = content
  end

  def perform
    Image.find_or_create_by(content: content)
  end

  private

  attr_reader :content
end
