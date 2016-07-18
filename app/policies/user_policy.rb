class UserPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    @current_user.admin? || @current_user == @model
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    @current_user.admin?
  end

  def permitted_attributes
    if @current_user.admin?
      [:role]
    else
      [:name, :email]
    end
  end

  class Scope < Scope
    attr_reader :current_user, :model

    def initialize(current_user, model)
      @current_user = current_user
      @model = model
    end

    def resolve
      if current_user.admin?
        model.all
      else
        model.where(id: current_user.id)
      end
    end
  end
end
