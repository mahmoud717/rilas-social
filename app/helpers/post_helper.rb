module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def friends?(user)
    friends = current_user.friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends.compact
    result = friends.include?(user)
    result
  end
end
