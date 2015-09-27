class VimeoLink
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

  # Inspired by http://stackoverflow.com/a/11660798/326111
  def valid_regex
    /^.*(vimeo\.com\/)((channels\/[A-z]+\/)|(groups\/[A-z]+\/videos\/))?([0-9]+)/
  end
end
