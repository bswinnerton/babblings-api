require 'app/graph/types/root_query'

module Graph
  Schema = GraphQL::Schema.new(query: Types::RootQuery)
end
