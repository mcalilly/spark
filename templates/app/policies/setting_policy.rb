class SettingPolicy < ApplicationPolicy

  def index?
    user.present? && user.admin?
  end

  def show?
    index?
  end

  def create?
    user.present? && user.admin?
  end

  def new?
    create?
  end

  def update?
    user.present? && user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && user.admin?
  end

end
