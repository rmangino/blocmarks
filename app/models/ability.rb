class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # default user

    # as long as a user owns the topic it can do anything it likes with it
    can [:manage], Topic do |topic|
      !user.new_record? && topic.try(:user) == user
    end
    can :create, Topic if !user.new_record?

    # as long as a user owns the topic/bookmark it can do anything it likes with it
    can [:manage], Bookmark do |bookmark|
      !user.new_record? && bookmark.topic.try(:user) == user
    end
    can :create, Bookmark if !user.new_record?

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
