require 'net/http'
require 'json'

class RemoteDataSet
  ENDPOINT = 'http://babblin.gs/api/v1/posts'.freeze

  def initialize(page:)
    @page = page
    @iterated_over_all_pages = false
  end

  def self.fetch(page: 0)
    new(page: page).fetch
  end

  def fetch
    until iterated_over_all_pages
      if posts.present?
        posts.each do |post|
          next unless post['type'] == 'Picture'

          CreateImage.perform(url: post['full_image']).update(
            source: post['content'],
            deleted_at: post['deleted_at'],
            created_at: post['created_at'],
          )
        end
      else
        complete!
      end

      next_page
    end
  end

  def complete!
    @iterated_over_all_pages = true
  end

  def next_page
    @page += 1
  end

  def posts
    parsed_response['posts']
  end

  private

  attr_reader :iterated_over_all_pages, :page

  def endpoint
    URI("#{ENDPOINT}?page=#{page}")
  end

  def parsed_response
    response = Net::HTTP.get(endpoint)
    JSON.parse(response)
  end
end

RemoteDataSet.fetch
