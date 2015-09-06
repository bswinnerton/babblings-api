module API::V1
  class ImagesAPI < Grape::API
    version 'v1'

    resources :images do
      get do
        images = Image.all #TODO: Add pagination
        present images, with: Entities::ImageEntity
      end


      params do
        requires :id,
          type: Integer,
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
    end
  end
end
