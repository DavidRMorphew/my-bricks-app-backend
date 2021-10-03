class ApplicationController < ActionController::API
    def encode_token
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
end
