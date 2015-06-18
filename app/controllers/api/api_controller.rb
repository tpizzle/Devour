module Api
  class ApiController < ApplicationController
    before_action :require_logged_in!

    def require_logged_in!
      unless logged_in?
        render json: ["You must be signed in to perform that action!"], status: :unauthorized
      end
    end

    def enforce_ownership

    end
  end
end
