class Abilities::Manager < Abilities::Ability
  def initialize(user)
    if user.has_role? Role::ADMIN
      can :manage, :all
    end
  end
end