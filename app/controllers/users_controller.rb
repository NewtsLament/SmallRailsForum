# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user_from_id, only: %i[show edit update]
  authorize_resource
  def index
    @max_user_id = User.order(:id).last.id
    if range_params[:from_id].nil? || range_params[:count].nil?
      @users = [User.first]
    else
      from_id = range_params[:from_id].to_i
      count = range_params[:count].to_i
      if count >= 0
        @users = User.where(id: from_id..(from_id+count)).all
      else
        @users = User.where(id: from_id+count..(from_id-1)).all
      end
    end
  end
  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def range_params
    params.permit(:from_id,:count)
  end
  def user_params
    params.require(:user).permit(:role)
  end
  def set_user_from_id
    @user = User.find(params[:id])
  end
end
