require 'app/graph/node_identification'

module Graph
  module Types
    RootQuery = GraphQL::ObjectType.define do
      name 'RootQuery'
      description 'The query root.'

      field :node, :field => NodeIdentification.field
    end
  end
end
