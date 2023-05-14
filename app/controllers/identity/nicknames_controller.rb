class Identity::NicknamesController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    if !@user.authenticate(params[:current_password])
      redirect_to edit_identity_nickname_path, alert: "The password you entered is incorrect"
    elsif @user.update(nickname: params[:nickname])
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
