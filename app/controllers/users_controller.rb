class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def friends
    @friends = current_user.friendships.map { |friendship| friendship.friend if friendship.confirmed }
    @friends = [] if @friends == [nil]
  end
end
