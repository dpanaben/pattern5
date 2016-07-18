class SanitizePolicy < ApplicationPolicy
  def index?
    return false if @current_user.nil?
    @current_user.admin? || @current_user.vip?
  end

  def show?
    index?
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
      end
    end

  end
end
