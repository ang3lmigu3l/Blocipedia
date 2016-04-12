class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index?
  end

  def show?
  end

  def new?
    @user.present?
  end

  def create?
    @user.present?
  end

  def edit
    @user.present?
  end

  def update?
    @user.present?
  end

  def destroy?
    @user.present?
  end

end
