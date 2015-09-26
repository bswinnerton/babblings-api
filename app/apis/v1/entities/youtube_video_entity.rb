module API
  module V1
    module Entities
      class YoutubeVideoEntity < Grape::Entity
        format_with(:iso_timestamp) { |dt| dt.iso8601 }

        expose :id,
          documentation: {
            type: 'integer',
            desc: 'YouTube Video ID'
          }

        expose :content,
          documentation: {
            type: 'string',
            desc: 'The URL to the iframe of the video'
          }

        with_options(format_with: :iso_timestamp) do
          expose :created_at,
            documentation: {
              type: 'datetime',
              desc: 'The date and time the video was created'
            }

          expose :updated_at,
            documentation: {
              type: 'datetime',
              desc: 'The date and time the video record was last updated'
            }
        end
      end
    end
  end
end
