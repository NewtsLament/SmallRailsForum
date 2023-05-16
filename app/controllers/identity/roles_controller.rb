# frozen_string_literal: true

class Identity::RolesController < ApplicationController
  before_action :set_user, only: %i[ edit update ]
  def edit
    authorize! :edit, @user
  end
  def update
    authorize! :patch, @user
    if @user.update(role: params[:role])
      redirect_to_root
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = Current.user
  end
  def redirect_to_root
    redirect_to root_path, notice: "Your nickname has been changed"
  end
end
