class TweetsController < ApplicationController
    before_action :set_tweet, only: [:show, :edit, :update, :destroy]
    before_action :logged_in_user
    before_action :require_user , only: [:edit, :update , :destroy]
   
  
    def index
        @users = User.all
        @user = User.new
        @tweets = Tweet.all.order("created_at DESC")
        @tweet = Tweet.new
    end
  
    def show
      @comment = Comment.new
      @comments = @tweet.comments.all
    end
  
    def new
        
        @tweet = current_user.tweets.build
    end
  
    def create
    @tweet = current_user.tweets.build(tweet_params)
      
     if @tweet.save
        flash[:notice] = "Posted."
        redirect_to(tweets_path)
      else
        render('new')
      end
    end
  
    def edit
      
    end
  
    def update
      
      if @tweet.update_attributes(tweet_params)
        flash[:notice] = "Updated."
        redirect_to(tweets_path)
      else
        render('edit')
      end
    end
  
    def delete
     
     
    end
  
    def destroy
      
      @tweet.destroy
      flash[:notice] = "Deleted."
      redirect_to(tweets_path)
    end

    def like
      like = Like.create(like: params[:like], user: current_user, tweet: @tweet)
      if like.valid?
        flash[:notice] = "Done!"
        redirect_to tweet_path(@tweet)
      else
        flash[:danger] = "there's something wrong"
        redirect_to tweet_path(@tweet)
      end
    end
  
    private
  
    def set_tweet
        @tweet = Tweet.find_by(id:params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def tweet_params
        params.require(:tweet).permit(:tweet)
      end

      def require_user
        if current_user != @tweet.user 
          #redirecting for now
          flash[:now] = "You can't peform this operation!"
          redirect_to root_path
        end
      end
  
  end
  