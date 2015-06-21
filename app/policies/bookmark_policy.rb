class BookmarkPolicy < ApplicationPolicy
  def update?
    user.present? && (record.topic == user.topic || user.admin?)
  end
  
  def edit?
    update?
  end
  
  def destroy?
    update?
  end
  
  
end