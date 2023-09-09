# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.persisted?
      if user.owner?
        can :manage, :all
        # can %i[update destroy], Category, owner_id: user.id
      elsif user.author?
        can %i[create destroy], Blog, author_id: user.id
        can :update, Blog do |blog|
          blog.author_id == user.id || blog.contributors.exists?(user.id)
        end
        can %i[create destroy update], Comment
        can :manage, User, id: user.id
      end
    end
    can :read, [Company, Comment, Category, Blog, User]
  end
end
