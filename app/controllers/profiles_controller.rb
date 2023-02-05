class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]

  def show; end
  def edit; end

  def update
    if @user.update(user_params)
      if params.dig(:user, :avatar).present?
        images = ActiveStorage::Attachment.where(record_id: current_user.id)
        images.each(&:purge)
        @user.avatar.attach(params[:user][:avatar])
      end
      redirect_to profile_path, success: t('.success')
    else
      flash.now['danger'] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to root_path, success: t('.success'), status: :see_other
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :introduction, :height, :body_weight,
                                 :age, :sex, :active_level, :target_weight,
                                 :target_date, :adjustment_calorie, :twitter_link, :facebook_link, :instagram_link, :avatar)
  end
end
