class AccessPolicy < ApplicationPolicy
  def index?
    return false if @current_user.nil?
    @current_user.admin?
  end

  class Scope < Scope
  end
end
