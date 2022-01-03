class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end
  def my_friends
    @friends = current_user.friends
  end
  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_results'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol to search"
          format.js { render partial: 'users/friend_results'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter text"
        format.js { render partial: 'users/friend_results'}
      end
    end
  end


end
