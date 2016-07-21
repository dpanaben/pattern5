class SanitizePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    @current_user.admin? || (@model.user_id == @current_user.id)
  end

  def create?
    true
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  def changestatus?
    show?
  end

  class Scope < Scope
    attr_reader :current_user, :model

    def initialize(current_user, model)
      @current_user = current_user
      @model = model
    end

    def resolve
      if current_user.admin? || current_user.vip?
        model.all
      else
        model.where(user_id: current_user.id)
      end
    end

  end
end
