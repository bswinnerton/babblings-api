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

        resolve -> (object, arguments, context) do
          ::Image.all
        end
      end
    end
  end
end
