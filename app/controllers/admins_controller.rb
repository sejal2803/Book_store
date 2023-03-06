class AdminsController < ApplicationController

  # POST /admins
  # Create a new admin
  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      render json: @admin, status: :created
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  # PATCH/admins/:id
  # Update Existed Admin
  def update
    debugger
    @admin = Admin.find(params[:id])
    debugger
    if @admin.update(admin_params)
      render json: { message: 'Admin details updated successfully' }, status: :ok
    else
      render json: { error: 'Failed to update admin details' }, status: :unprocessable_entity
    end
  end
      
  private
      
  # Permitted parameters for creating or updating an Admin
  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end
end
