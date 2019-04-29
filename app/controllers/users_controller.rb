class UsersController < ApplicationController
    
    before_action :logged_in?, only: [ :show, :index, :edit, :update, :destroy]
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_same_user , only: [ :edit, :update , :destroy]
    
  
    def index
        @users = User.paginate(page: params[:page])
        @tweets = Tweet.all
      end

    def show
        @tweets = @user.tweets.paginate(page: params[:page])
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = 'Created successfully.'
        redirect_to(users_path)
      else
        render('new')
      end
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:notice] = 'user updated successfully.'
        redirect_to(users_path)
      else
        render('edit')
      end
    end
  
    def delete
      @user = User.find(params[:id])
    end
  
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "user destroyed successfully."
      redirect_to(users_path)
    end

    def feed
        following_ids = "SELECT followed_id FROM relationships
        WHERE  follower_id = :user_id"
       Tweet.where("user_id IN (#{following_ids})
        OR user_id = :user_id", user_id: id)
      end
  
    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
      end
  
    def user_params
      # Permit :password, but NOT :password_digest
      params.require(:user).permit(
        :email,
        :username,
        :password
      )
    end

    def require_same_user
      if current_user != @user && !current_user
        flash[:danger] = "you do not have permition to peform this"
        redirect_to root_path
      end
    end
  
  end
  