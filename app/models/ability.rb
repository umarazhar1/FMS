# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.manager?
      # Managers can manage all projects
      can :manage, Project#, creator_id: user.id
    elsif user.developer? || user.qa?
      # Developers and QAs can view and edit bugs they are associated with
      can :read, Bug, project_id: user.projects.pluck(:id)
      # Developers and QAs can view projects they are associated with
      can :read, Project, id: user.projects.pluck(:id)
    elsif user.qa?
      # Only QA can view and edit bugs they are associated with
      can [:read, :write, :edit, :update ], Bug, project_id: user.projects.pluck(:id)
    else
      # Default: Guests have no abilities
      cannot :read, Project
      cannot :read, Bug
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
  end
end
