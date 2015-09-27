module API::V1
  class VimeoVideosAPI < Grape::API
    include Grape::Kaminari

    version 'v1'

    resources 'vimeo-videos' do
      paginate
      get do
        videos = paginate(VimeoVideo.all)
        present videos, with: Entities::VimeoVideoEntity
      end


      params do
        requires :id,
          type: String,
          allow_blank: false,
          desc: 'The identifier of the Vimeo video'
      end
      route_param :id do
        get do
          video = VimeoVideo.find(declared_params[:id])
          present video, with: Entities::VimeoVideoEntity
        end
      end


      params do
        requires :source,
          type: String,
          allow_blank: false,
          desc: 'The URL of the Vimeo video'
      end
      post do
        video = CreateVimeoVideo.perform(declared_params)
        present video, with: Entities::VimeoVideoEntity
      end


      params do
        requires :id,
          allow_blank: false,
          desc: 'The Babblings id of the Vimeo video'
      end
      delete do
        video = VimeoVideo.find(declared_params[:id]).destroy
        present video, with: Entities::VimeoVideoEntity
      end
    end
  end
end
