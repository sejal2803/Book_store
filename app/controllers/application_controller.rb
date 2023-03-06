class ApplicationController < ActionController::API
  # Before every request, authenticate the request
  before_action :authenticate_request

  # Require JWT module for token encoding and decoding
  require 'jwt'

  # Method to get the current admin
  def current_admin
    current_admin = @current_admin
  end

  private

  # Method to authenticate the request using JWT token
  def authenticate_request
    # Get the token from the request header
    header = request.headers["Authorization"]

    # Extract the token from the header if it exists
    header = header.split(" ").last if header

    # Decode the token using the jwt_decode method and get the admin id from the payload
    decoded = jwt_decode(header)
    @current_admin = Admin.find(decoded[:admin_id])
  end

  # Method to encode payload into a JWT token
  def jwt_encode(payload)
    secret_key = Rails.application.secret_key_base
    JWT.encode(payload, secret_key)
  end

  # Method to decode a JWT token and return the payload as a HashWithIndifferentAccess object
  def jwt_decode(authorization)
    secret_key = Rails.application.secret_key_base
    decoded_token = JWT.decode(authorization, secret_key)
    HashWithIndifferentAccess.new(decoded_token[0])
  end
end
