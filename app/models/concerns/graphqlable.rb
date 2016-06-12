require 'active_support/concern'

module GraphQLable
  extend ActiveSupport::Concern

  included do
    def graphql_global_id
      klass = self.class.name
      id    = self.id
      GraphQL::Relay::GlobalNodeIdentification.to_global_id(klass, id)
    end
  end
end
