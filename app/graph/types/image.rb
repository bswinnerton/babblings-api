module Graph
  module Types
    Image = GraphQL::ObjectType.define do
      name 'Image'
      description 'A post where the content type is an image'

      interfaces [NodeIdentification.interface]
      global_id_field :id

      field :source, types.String, 'The CDN URL'
      field :origin, types.String, 'The originating URL'
      field :width, types.Int, 'The width in pixels'
      field :height, types.Int, 'The height in pixels'
      field :deleted_at, types[DateTime], 'The time of deletion'
      field :created_at, types[DateTime], 'The time of creation'
      field :updated_at, types[DateTime], 'The time of the last update'
      field :processing, !types.Boolean, 'Whether the image is still being uploaded'
    end
  end
end
