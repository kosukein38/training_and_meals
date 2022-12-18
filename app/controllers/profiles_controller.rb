class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]

  def show; end
  def edit; end

  def update
    if @user.update(user_params)
      @user.avatar.attach(params[:user][:avatar])
      set_coefficient
      @user.maintenance_calorie = if @user.male?
                                    ((13.397 * @user.body_weight) + (4.799 * @user.height) - (5.677 * @user.age) + 88.362) * @coefficient
                                  else
                                    ((9.247 * @user.body_weight) + (3.098 * @user.height) - (4.33 * @user.age) + 447.593) * @coefficient
                                  end
      @user.target_calorie = (@user.maintenance_calorie + user_params[:adjustment_calorie].to_i + 500)
      @user.save!
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

  def set_coefficient
    @coefficient = case @user.active_level
                   when 'level1'
                     1.2
                   when 'level2'
                     1.375
                   when 'level3'
                     1.55
                   when 'level4'
                     1.725
                   when 'level5'
                     1.9
                   else
                     1
                   end
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :introduction, :height, :body_weight,
                                 :age, :sex, :active_level, :target_weight,
                                 :target_date, :adjustment_calorie, :twitter_link, :facebook_link, :instagram_link, :avatar)
  end
end
