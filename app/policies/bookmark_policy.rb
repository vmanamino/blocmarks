class BookmarkPolicy < ApplicationPolicy
  def update?
    user.present? && (record.user == user || user.admin?)
  end
  
  def edit?
    update?
  end
  
  def destroy?
    update?
  end
  
  
end