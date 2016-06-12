require 'app/graph/types/root_query'
require 'app/graph/types/date_time'
require 'app/graph/types/image'

module Graph
  Schema = GraphQL::Schema.new(
    query: Types::RootQuery,
    types: [Types::DateTime, Types::Image]
  )
end
