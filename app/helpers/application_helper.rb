module ApplicationHelper

  def user_not_admin
    current_user && (current_user.standard? || current_user.premium?)
  end

  def user_premium_or_admin
    current_user && (current_user.premium? || current_user.admin?)
  end
end
