class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = I18n.t('notice.you_failed_to_log_in')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = I18n.t('notice.you_logged_out')
    redirect_to new_session_path
  end
end
