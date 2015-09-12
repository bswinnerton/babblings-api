module API
  module V1
    module Entities
      class ImageEntity < Grape::Entity
        format_with(:iso_timestamp) { |dt| dt.iso8601 }

        expose :id,
          documentation: {
            type: 'integer',
            desc: 'Image ID'
          }

        expose :content,
          documentation: {
            type: 'string',
            desc: 'The URL of the image'
          }

        expose :width,
          documentation: {
            type: 'integer',
            desc: 'The width of the image'
          }

        expose :height,
          documentation: {
            type: 'integer',
            desc: 'The height of the image'
          }

        with_options(format_with: :iso_timestamp) do
          expose :created_at,
            documentation: {
              type: 'datetime',
              desc: 'The date and time the image was created'
            }

          expose :updated_at,
            documentation: {
              type: 'datetime',
              desc: 'The date and time the image record was last updated'
            }
        end
      end
    end
  end
end
