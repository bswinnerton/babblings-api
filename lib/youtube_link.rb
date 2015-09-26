class YoutubeLink
  def initialize(url)
    @url = url
  end

  def id
    matches[5]
  end

  private

  attr_reader :url

  def matches
    valid_regex.match(url).to_a
  end

  # Inspired by https://gist.github.com/afeld/1254889
  def valid_regex
    /(youtu\.be\/|youtube\.com\/(watch\?(.*&)?v=|(embed|v)\/))([^\?&"'>]+)/
  end
end
