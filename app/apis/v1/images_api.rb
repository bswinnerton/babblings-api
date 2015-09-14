module API::V1
  class ImagesAPI < Grape::API
    include Grape::Kaminari

    version 'v1'

    resources :images do
      paginate
      get do
        images = paginate(Image.all)
        present images, with: Entities::ImageEntity
      end


      params do
        requires :id,
          type: String,
          allow_blank: false,
          desc: 'The identifier of the image'
      end
      route_param :id do
        get do
          image = Image.find(declared_params[:id])
          present image, with: Entities::ImageEntity
        end
      end


      params do
        requires :url,
          type: String,
          allow_blank: false,
          desc: 'The URL of the image'
      end
      post do
        image = CreateImage.perform(declared_params)
        present image, with: Entities::ImageEntity
      end


      params do
        requires :id,
          allow_blank: false,
          desc: 'The identifier of the image'
      end
      delete do
        image = Image.find(declared_params[:id]).destroy
        present image, with: Entities::ImageEntity
      end
    end
  end
end
