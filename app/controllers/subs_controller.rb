class SubsController < ApplicationController
  before_action :require_logged_in, except: [:index, :show]
  before_action :require_sub_ownership, only: [:edit, :update, :destroy]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors]=@sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
  end

  def update
    @sub = Sub.find_by(id: params[:id])
      if @sub.update_attributes(sub_params)
        redirect_to sub_url(@sub)
      else
        flash.now[:errors]=@sub.errors.full_messages
        render :edit
      end
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find_by(id: params[:id])
  end

  def destroy
    @sub = Sub.find_by(id: params[:id])
    if @sub
      @sub.destroy
      redirect_to subs_url
    else
      flash[:errors]=@sub.errors.full_messages
      redirect_to sub_url(@sub)
    end
  end

  private

  def require_sub_ownership
    @sub = Sub.find_by(id: params[:id])
    unless current_user == @sub.moderator
      flash[:errors]=["Cannot modify someone else\'s sub!"]
      redirect_to sub_url(@sub)
    end
  end

  def sub_params
    params.require(:sub).permit(:title,:description)
  end
end
