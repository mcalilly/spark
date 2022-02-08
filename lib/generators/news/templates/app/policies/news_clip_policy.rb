class NewsClipPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @setting = model
  end

  def index?
    true
  end

  def show?
    index?
  end

  def create?
    @current_user.admin?
  end

  def new?
    create?
  end

  def update?
    @current_user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

end
