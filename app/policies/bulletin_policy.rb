# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    record.published? || author? || user.admin?
  end

  def edit?
    author?
  end

  def new?
    user
  end

  def update?
    author?
  end

  def create?
    new?
  end

  def to_moderate?
    author?
  end

  def archive?
    author?
  end

  private

  def author?
    record.user == user
  end
end
