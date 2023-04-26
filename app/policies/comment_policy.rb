class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def update?
    user.id == record.commenter_id
  end

  def destroy?
    user.id == record.commenter_id
  end
end
