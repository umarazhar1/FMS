# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      # Admin can create folders and manage all the folders created by anyone
      can :manage, Folder
      # Admin can create qrs and manage all the qrs created by anyone
      can :manage, Qr
    elsif user.simple_user?
      # Simple user can create folders and manage only their own folders that have been created by themselves
      can :manage, Folder, user_id: user.id
      # Simple user can create qrs and manage only their own qrs that have been created by themselves
      can :manage, Qr, user_id: user.id

      # can :manage, Qr, folder_id: { user_id: user.id }
    else
      # Default: Guests have no abilities
      cannot :read, Folder
      cannot :read, Qr
    end
  end
end

# Define abilities for the user here. For example:
#
#   return unless user.present?
#   can :read, :all
#   return unless user.admin?
#   can :manage, :all
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
#   can :update, Article, published: true
#
# See the wiki for details:
# https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
