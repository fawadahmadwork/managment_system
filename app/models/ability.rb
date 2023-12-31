class Ability
  include CanCan::Ability

  def initialize(admin_user)
    can :read, ActiveAdmin::Page, name: "Dashboard"
    if admin_user.superadmin?
      can :manage, :all
    elsif admin_user.admin?
      can :manage, :all
      cannot :manage, Leave 
      cannot :manage, AdminUser
    else admin_user.hr?
      can :read, :all
      cannot :manage, AdminUser 
      cannot :manage, Leave 

    end
  end
end
