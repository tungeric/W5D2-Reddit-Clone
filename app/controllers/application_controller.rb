class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def login!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token]=nil
  end

  def logged_in?
    !current_user.nil?
  end

  def require_logged_in
    unless logged_in?
      flash[:errors] = ["You must be logged in"]
      redirect_to new_session_url
    end
  end

  def upvote
    @vote = Vote.find_by(
                user_id: current_user.id,
                votable_id: params[:id],
                votable_type: params[:controller].capitalize.singularize
                ) ||
    Vote.new(
    user_id: current_user.id,
    votable_id: params[:id],
    votable_type: params[:controller].capitalize.singularize
    )
    @vote.value = 1
    @vote.save
    redirect_back(fallback_location: subs_url)
  end

  def downvote
    @vote = Vote.find_by(
                user_id: current_user.id,
                votable_id: params[:id],
                votable_type: params[:controller].capitalize.singularize
                ) ||
    Vote.new(
    user_id: current_user.id,
    votable_id: params[:id],
    votable_type: params[:controller].capitalize.singularize
    )
    @vote.value = -1
    @vote.save
    redirect_back(fallback_location: subs_url)
  end
end
