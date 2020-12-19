module SessionsHelper
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    current_user.present?
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = I18n.t('notice.please_log_in')
      redirect_to new_session_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    if @user != current_user
      flash[:danger] = I18n.t('notice.only_correct_user_have_access')
      redirect_to root_url
    end
  end

end
