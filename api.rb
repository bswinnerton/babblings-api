require './config/environment'

module API
  class Root < Grape::API
    active_record_debug = (ENV['ACTIVE_RECORD_DEBUG'] == 'true')
    ActiveRecord::Base.logger.level = Logger::INFO unless active_record_debug

    format :json
    prefix :api

    helpers ParamsHelpers

    rescue_from Grape::Exceptions::ValidationErrors do |exception|
      error!(exception, 400)
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      error!('Not found', 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      error!(exception.record.errors, 422)
    end

    rescue_from :all do |exception|
      API::Root.logger.error(exception)
      Raygun.track_exception(exception, env)
      error!('Internal Server Error', 500)
    end

    mount API::V1::ImagesAPI
    mount API::V1::VimeoVideosAPI
    mount API::V1::YoutubeVideosAPI
  end
end
