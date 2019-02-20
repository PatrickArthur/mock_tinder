module Api
  # Base controller for API actions
  class BaseController < ApplicationController
    layout false

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    protected

    def record_not_found
      render \
        json: {
          data: nil,
          code: 404,
          status: 'not_found',
          message:  'Record not found'
        },
        status: :not_found
    end
  end
end
