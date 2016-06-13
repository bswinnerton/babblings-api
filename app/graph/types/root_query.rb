require 'app/graph/node_identification'

module Graph
  module Types
    RootQuery = GraphQL::ObjectType.define do
      name 'RootQuery'
      description 'The query root.'

      field :node, :field => NodeIdentification.field

      connection :images, -> { !Graph::Types::Image.connection_type } do
        description 'Return all images'
        type -> { Graph::Types::Image }

        argument :processing, types.Boolean

        resolve -> (object, arguments, context) do
          if arguments[:processing]
            ::Image.where(processing: false)
          else
            ::Image.all
          end
        end
      end
    end
  end
end
