class App < Sinatra::Base
  get '/' do
    "Nothing to see here. Move along."
  end

  post '/graphql' do
    "OK"
  end
end
