class ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def index?
    false
  end

  def show?
    false
    #scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(current_user, model)
  end

  class Scope
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

    def permitted_attributes
      if @current_user.admin?
        [:role]
      else
        [:name, :email]
      end
    end

  end
end
