class ApplicationController < ActionController::API
    def encode_token
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decoded_token
        if request.headers['Authorization']
          token = request.headers['Authorization'].split(' ')[1]
          begin
            JWT.decode(token, Rails.application.secrets.secret_key_base, 
                true, algorithm: 'HS256')
          rescue JWT::DecodeError
            nil
          end
        end
    end
end
