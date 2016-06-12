class App < Sinatra::Base
  get '/' do
    'Nothing to see here. Move along.'
  end

  post '/graphql' do
    Graph::Schema.execute(query, variables: params[:variables]).to_json
  end

  private

  def query
    graphql_params.fetch(:query, '')
  end

  def variables
    return unless graphql_params[:variables].present?
    JSON.parse(graphql_params[:variables])
  end

  def graphql_params
    @graphql_params ||= JSON.parse(request.body.read).symbolize_keys
  end
end
