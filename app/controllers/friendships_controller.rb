class FriendshipsController < ApplicationController
    def new
        user = User.find(params[:user_id])
        user.friendships.create(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: false)
        redirect_back fallback_location: root_path
    end
    def confirm
        friendship = Friendship.find(params[:friendship_id])
        friendship.confirmed = true
        friendship.save
        user = User.find(friendship.user_id)
        friend = User.find(friendship.friend_id)
        friend.friendships.create(user_id: friend.id , friend_id: user.id, confirmed: true)
        redirect_back fallback_location: root_path
    end
    def cancel
        friendship = Friendship.find(params[:friendship_id])
        user = User.find(friendship.friend_id)
        friend_request = user.friendship_requests.find_by(user_id: friendship.user_id)
        friend_request.destroy
        friendship.destroy
        redirect_back fallback_location: root_path
    end
    def unfriend
        # destroy first friendship
        friendship1 = Friendship.find_by(user_id: params[:user_id])
        user1 = User.find(params[:user_id])
        friend_request1 = user1.friendship_requests.find_by(user_id: params[:user_id])
        friend_request1.destroy if friend_request1
        friendship1.destroy if friendship1

        # destroy second friendship
        friendship2 = Friendship.find_by(user_id: params[:friend_id])
        user2 = User.find(params[:friend_id])
        friend_request2 = user2.friendship_requests.find_by(user_id: params[:friend_id])
        friend_request2.destroy if friend_request2
        friendship2.destroy if friendship2
        
        redirect_back fallback_location: root_path
    end
end
