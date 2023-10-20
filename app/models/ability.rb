class Ability
  include CanCan::Ability

  def initialize(admin_user)
    can :read, ActiveAdmin::Page, name: "Dashboard"
    if admin_user.superadmin?
      can :manage, :all
    elsif admin_user.admin?
      can :manage, :all
      cannot :manage, AdminUser 
      can :read, AdminUser 
    else admin_user.hr?
      can :manage, Employee

    end
  end
end
