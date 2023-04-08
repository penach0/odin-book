class FriendshipPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def update?
    user.id == record.friend_id
  end

  def destroy?
    user.id == record.friend_id || user.id == record.user_id
  end
end
