module UserHelper
    def user_display(user)
        link_to 'See Profile', user_path(user), class: 'profile-link'
        if current_user.friend?(user)
        "<p>Friend</p>".html_safe
         link_to "Unfriend", unfriend_path(current_user.id, user.id), method: "POST"
        elsif current_user.friend_requests.include?(user)
         (link_to "confirm", confirmfriendrequest_path(Friendship.find_by(user_id: user.id).id) , method: "POST")+
         (link_to "cancel", cancelfriendrequest_path(Friendship.find_by(user_id: user.id).id) , method: "POST")
        elsif user.friend_requests.include?(current_user)
        "<p> request sent
        </p>".html_safe
        else
         link_to "Add Friend" , sendfriendrequest_path(current_user.id, user.id), method: "POST"
        end
    end
end