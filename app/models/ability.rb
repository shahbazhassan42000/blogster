# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.persisted?
      if user.owner?
        can :manage, :all
        cannot :manage, BlogsUser
        cannot :update, Comment
        can :update, Comment, commentor_id: user.id
        can :update, BlogsUser, blog: { author_id: user.id }
      elsif user.author?
        can :manage, BlogsUser, blog: { author_id: user.id }
        can %i[create destroy], Blog, author_id: user.id
        can :update, Blog do |blog|
          blog.author_id == user.id || blog.contributors.exists?(user.id)
        end
        can :create, Comment
        can :update, Comment, commentor_id: user.id
        can :destroy, Comment do |comment|
          if comment.commentable_type == 'Blog'
            comment.commentor_id == user.id || comment.commentable.author_id == user.id
          else
            comment.commentor_id == user.id || comment.commentable.company.owner_id == user.id
          end
        end
        can :manage, User, id: user.id
      end
    end
    can :read, [Company, Comment, Category, Blog, User, BlogsUser]
  end
end
