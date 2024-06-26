# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    record.user == user
  end

  def new?
    user
  end

  def update?
    edit?
  end

  def create?
    new?
  end
end
