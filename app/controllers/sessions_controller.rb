class SessionsController < ApplicationController
  # Skips authentication for create action
  skip_before_action :authenticate_request

  # Create a new session for an admin user
  def create
    admin = Admin.find_by(email: params['email'].downcase)

    if admin && admin.authenticate(params['password'])
      # Generate a new JWT token for the authenticated user
      token = jwt_encode(admin_id: admin.id)
        # Calculate token expiry time
      time = Time.now + 7.days.to_i
      render json: { token: token, exp: time.strftime("%d-%m-%Y %H:%M"), username: admin.name }, status: :ok
    else
      render json: { error: "unauthorized"}, status: :unprocessable_entity
    end
  end
end
