require './config/environment'

module API
  class Root < Grape::API
    active_record_debug = (ENV['ACTIVE_RECORD_DEBUG'] == 'true')
    ActiveRecord::Base.logger.level = Logger::INFO unless active_record_debug

    format :json
    prefix :api

    helpers ParamsHelpers

    rescue_from Grape::Exceptions::ValidationErrors do |exception|
      errors = exception.errors.each_with_object({}) do |(field, error), hash|
        key = field.first.split(/\[(.*?)\]/).last
        hash[key] = [error: error.first.message.sub(' ', '_')]
      end

      error_response(message: { errors: errors }, status: 400)
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      error_response(message: 'Not found', status: 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      error!(exception.record.errors, 422)
    end

    rescue_from :all do |exception|
      Raygun.track_exception(exception) if defined? Raygun
      show_exception_backtrace = (ENV['SHOW_EXCEPTION_BACKTRACE'] == 'true')

      payload = {error: 'Internal Server Error'} #TODO: unify format of JSON API
      payload.merge!(title: exception.message, data: exception.backtrace) if show_exception_backtrace
      error!(payload, 500)
    end

    mount API::V1::ImagesAPI
  end
end
