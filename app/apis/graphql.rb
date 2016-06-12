class App < Sinatra::Base
  get '/' do
    'Nothing to see here. Move along.'
  end

  post '/graphql' do
    Graph::Schema.execute(params[:query], variables: params[:variables], debug: true)
  end
end
