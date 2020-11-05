class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  def timeline_posts
    @timeline_posts ||= Post.where('user_id IN (?)', user_and_friends).order(created_at: :desc)
  end

  def user_and_friends
    friends_and_me = current_user.friends.map(&:id)
    friends_and_me.push(current_user.id)
    friends_and_me
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
