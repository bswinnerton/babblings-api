module API::V1
  class YoutubeVideosAPI < Grape::API
    include Grape::Kaminari

    version 'v1'

    resources 'youtube-videos' do
      paginate
      get do
        videos = paginate(YoutubeVideo.all)
        present videos, with: Entities::YoutubeVideoEntity
      end


      params do
        requires :id,
          type: String,
          allow_blank: false,
          desc: 'The identifier of the YouTube video'
      end
      route_param :id do
        get do
          video = YoutubeVideo.find(declared_params[:id])
          present video, with: Entities::YoutubeVideoEntity
        end
      end


      params do
        requires :source,
          type: String,
          allow_blank: false,
          desc: 'The URL of the YouTube video'
      end
      post do
        video = CreateYoutubeVideo.perform(declared_params)
        present video, with: Entities::YoutubeVideoEntity
      end


      params do
        requires :id,
          allow_blank: false,
          desc: 'The Babblings id of the YouTube video'
      end
      delete do
        video = YoutubeVideo.find(declared_params[:id]).destroy
        present video, with: Entities::YoutubeVideoEntity
      end
    end
  end
end
