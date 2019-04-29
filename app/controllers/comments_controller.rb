class CommentsController < ApplicationController
    before_action :logged_in_user
    

    def create
        
        @tweet = Tweet.find(params[:tweet_id])
        @comment = @tweet.comments.create(comment_params)
        @comment.user = current_user
        if @comment.save
        redirect_to tweet_path(@tweet.id)
        else
        redirect_to tweet_path(@tweet.id)
        end
    end

    def destroy
        @tweet = Tweet.find(params[:tweet_id])
        @comment = @tweet.comments.find(params[:id])
        @comment.destroy
        redirect_to tweet_path(@tweet.id)
    end

    private 

    def comment_params
        params.require(:comment).permit(:comment)
    end

end