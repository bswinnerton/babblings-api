module Graph
  module Types
    DateTime = GraphQL::ScalarType.define do
      name 'DateTime'
      description 'A datetime formatted as ISO-8601'

      coerce_input -> (value) do
        Time.iso8601(value)
      end

      coerce_result -> (value) do
        value.utc.iso8601
      end
    end
  end
end
