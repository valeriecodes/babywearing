# frozen_string_literal: true

class FeeTypePolicy < ApplicationPolicy
  attr_reader :user, :fee_type

  ROLES = [:admin, :volunteer]

  def initialize(user, fee_type)
    @user = user
    @fee_type = fee_type
  end

  def new?
    authorized?(ROLES)
  end

  def create?
    authorized?(ROLES)
  end

  def edit?
    authorized?(ROLES)
  end

  def update?
    authorized?(ROLES)
  end

  def destroy?
    authorized?(ROLES)
  end

  private

  def authorized?(roles)
    @user.has_any_role?(*roles)
  end
end
